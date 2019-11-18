package connection

import (
	"context"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/wait"
	"testing"
	"time"
	"trak-gateway/takealot/model"
)

func TestGetMariaDB(t *testing.T) {
	env := make(map[string]string)
	env["MYSQL_ROOT_PASSWORD"] = "root"
	env["MYSQL_DATABASE"] = "trak"
	env["MYSQL_USER"] = "user"
	env["MYSQL_PASSWORD"] = "password"

	ctx := context.Background()
	req := testcontainers.ContainerRequest{
		Image:        "mariadb:10.4.8-bionic",
		ExposedPorts: []string{"3306/tcp"},
		Env:          env,
		WaitingFor:   wait.ForLog("Version: '10.4.8-MariaDB-1:10.4.8+maria~bionic'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  mariadb.org binary distribution").WithPollInterval(1 * time.Second),
	}
	mariadbC, err := testcontainers.GenericContainer(ctx, testcontainers.GenericContainerRequest{
		ContainerRequest: req,
		Started:          true,
	})
	if err != nil {
		t.Error(err)
	}
	defer terminate(ctx, mariadbC)

	ip, err := mariadbC.Host(ctx)
	if err != nil {
		t.Error(err)
	}

	port, err := mariadbC.MappedPort(ctx, "3306")
	if err != nil {
		t.Error(err)
	}

	opts := MariaDBConnectOpts{
		Host:            ip,
		Port:            port.Int(),
		Database:        "trak",
		User:            "user",
		Password:        "password",
		ConnMaxLifetime: time.Hour,
		MaxIdleConns:    10,
		MaxOpenConns:    100,
	}

	db, err := GetMariaDB(opts)

	if err != nil {
		t.Errorf("should have no errors: %v", err)
	}

	if db == nil {
		t.Error("should not be nil")
	}

	model.MigrateModels(db)

	CloseMariaDB(db)
}
