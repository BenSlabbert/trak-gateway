package test_utils

import (
	"context"
	"fmt"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
	"path/filepath"
	"testing"
	"time"
	"trak-gateway/connection"
)

var mariadbContainerIP string
var mariadbContainerPort int

var nsqContainerIP string
var nsqContainerPort int

const mariadbSchema = "trak"
const mariadbUsername = "user"
const mariadbPassword = "password"

func SetUpNSQ() (context.Context, testcontainers.Container) {
	ctx := context.Background()
	req := testcontainers.ContainerRequest{
		Image:        "nsqio/nsq:v1.2.0",
		ExposedPorts: []string{"4150/tcp", "4151/tcp"},
		Cmd:          []string{"/nsqd"},
	}

	nsqC, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true,
	})

	if err != nil {
		log.Fatal(err)
	}

	ip, err := nsqC.Host(ctx)
	if err != nil {
		log.Fatal(err)
	}

	port, err := nsqC.MappedPort(ctx, "4150")
	if err != nil {
		log.Fatal(err)
	}

	nsqContainerIP = ip
	nsqContainerPort = port.Int()

	return ctx, nsqC
}

func SetUpMariaDB(dataFilePath string) (context.Context, testcontainers.Container) {
	mounts := make(map[string]string)
	absPath, _ := filepath.Abs(dataFilePath)
	mounts[absPath] = "/docker-entrypoint-initdb.d/trak.sql"

	env := make(map[string]string)
	env["MYSQL_ROOT_PASSWORD"] = "root"
	env["MYSQL_DATABASE"] = mariadbSchema
	env["MYSQL_USER"] = mariadbUsername
	env["MYSQL_PASSWORD"] = mariadbPassword

	ctx := context.Background()
	req := testcontainers.ContainerRequest{
		Image:        "mariadb:10.4.8-bionic",
		ExposedPorts: []string{"3306/tcp"},
		Env:          env,
		BindMounts:   mounts,
		WaitingFor: wait.ForLog("Version: '10.4.8-MariaDB-1:10.4.8+maria~bionic'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  mariadb.org binary distribution").
			WithPollInterval(1 * time.Second).
			WithStartupTimeout(5 * time.Minute),
	}
	mariadbC, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true,
	})

	if err != nil {
		log.Fatal(err)
	}

	ip, err := mariadbC.Host(ctx)
	if err != nil {
		log.Fatal(err)
	}

	port, err := mariadbC.MappedPort(ctx, "3306")
	if err != nil {
		log.Fatal(err)
	}

	opts := connection.MariaDBConnectOpts{
		Host:            ip,
		Port:            port.Int(),
		Database:        "trak",
		User:            "user",
		Password:        "password",
		ConnMaxLifetime: time.Hour,
		MaxIdleConns:    10,
		MaxOpenConns:    100,
	}

	db, err := connection.GetMariaDB(opts)

	if err != nil {
		log.Fatalf("should have no errors: %v", err)
	}

	if db == nil {
		log.Fatal("should not be nil")
	}

	connection.CloseMariaDB(db)

	mariadbContainerIP = ip
	mariadbContainerPort = port.Int()

	return ctx, mariadbC
}

func GetNSQProducer(t *testing.T) *nsq.Producer {
	config := nsq.NewConfig()
	producer, e := nsq.NewProducer(fmt.Sprintf("%s:%d", nsqContainerIP, nsqContainerPort), config)

	if e != nil {
		t.Errorf("should not error: %v", e)
	}

	return producer
}

func GetNSQConsumer(clientID, topic, channel string, t *testing.T) *nsq.Consumer {
	config := nsq.NewConfig()
	config.ClientID = clientID
	consumer, e := nsq.NewConsumer(topic, channel, config)

	if e != nil {
		t.Errorf("should not error: %v", e)
	}

	return consumer
}

func NSQConsumerConnect(consumer *nsq.Consumer, t *testing.T) {
	sprintf := fmt.Sprintf("%s:%d", nsqContainerIP, nsqContainerPort)
	e := consumer.ConnectToNSQD(sprintf)

	if e != nil {
		t.Errorf("should not error: %v", e)
	}
}

func GetDB(t *testing.T) *gorm.DB {
	opts := connection.MariaDBConnectOpts{
		Host:            mariadbContainerIP,
		Port:            mariadbContainerPort,
		Database:        mariadbSchema,
		User:            mariadbUsername,
		Password:        mariadbPassword,
		ConnMaxLifetime: time.Hour,
		MaxIdleConns:    10,
		MaxOpenConns:    100,
	}
	db, err := connection.GetMariaDB(opts)
	if err != nil {
		t.Errorf("should have no errors: %v", err)
	}
	if db == nil {
		t.Error("should not be nil")
	}
	return db
}

func Terminate(ctx context.Context, container testcontainers.Container) {
	if container.Terminate(ctx) != nil {
		log.Warnf("error while terminating container: %v", container.Terminate(ctx))
	}
}
