package main

import (
	"flag"
	"fmt"
	"github.com/bsm/redislock"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"
	"trak-gateway/connection"
	"trak-gateway/gateway/metrics"
	"trak-gateway/takealot/env"
	"trak-gateway/takealot/model"
	"trak-gateway/takealot/queue"
)

func main() {
	verbose := flag.Bool("v", false, "set verbose logging")
	flag.Parse()

	if *verbose {
		log.SetLevel(log.DebugLevel)
	}

	takealotEnv := env.LoadEnv()
	if takealotEnv.PPROFEnv.PPROFEnabled {
		log.Infof("exposing pprof on port: %d", takealotEnv.PPROFEnv.PPROFPort)
		router := mux.NewRouter()
		metrics.ExposePPROF(router)
		go func() {
			err := http.ListenAndServe(fmt.Sprintf(":%d", takealotEnv.PPROFEnv.PPROFPort), router)
			log.Warnf("failed to serve on port %d: %v", takealotEnv.PPROFEnv.PPROFPort, err)
		}()
	}

	opts := connection.MariaDBConnectOpts{
		Host:            takealotEnv.DB.Host,
		Port:            takealotEnv.DB.Port,
		Database:        takealotEnv.DB.Database,
		User:            takealotEnv.DB.Username,
		Password:        takealotEnv.DB.Password,
		ConnMaxLifetime: time.Hour,
		MaxIdleConns:    10,
		MaxOpenConns:    100,
	}

	if err := MigrateDB(takealotEnv, opts); err != nil {
		log.Fatalf("Failed to migrate db: %v", err)
	}

	if takealotEnv.MasterNode {
		go WorkerTaskFactory(opts, takealotEnv)
	}

	consumers := make([]*nsq.Consumer, 0)
	newProductTasks := make([]*queue.NSQNewProductTask, 0)
	for i := 0; i < takealotEnv.Nsq.NumberOfNewProductConsumers; i++ {
		db, e := connection.GetMariaDB(opts)
		if e != nil {
			log.Fatalf("failed to get db connection: %v", e)
		}
		client := connection.CreateRedisClient()
		newProductTask := &queue.NSQNewProductTask{
			DB:         db,
			LockClient: redislock.New(client),
			Producer:   queue.CreateNSQProducer(),
		}
		newProductTasks = append(newProductTasks, newProductTask)
		s := uuid.New().String()[:6]
		c := queue.CreateNSQConsumer(fmt.Sprintf("%s-nsq-new-product-worker-%d", s, i), queue.NewProductQueue, "worker")
		c.AddHandler(nsq.HandlerFunc(newProductTask.HandleMessage))
		queue.ConnectConsumer(c)
		consumers = append(consumers, c)
	}

	scheduledTaskHandlers := make([]*queue.NSQScheduledTaskHandler, 0)
	for i := 0; i < takealotEnv.Nsq.NumberOfScheduledTaskConsumers; i++ {
		db, e := connection.GetMariaDB(opts)
		if e != nil {
			log.Fatalf("failed to get db connection: %v", e)
		}
		scheduledTaskHandler := &queue.NSQScheduledTaskHandler{DB: db, Producer: queue.CreateNSQProducer()}
		scheduledTaskHandlers = append(scheduledTaskHandlers, scheduledTaskHandler)
		s := uuid.New().String()[:6]
		c := queue.CreateNSQConsumer(fmt.Sprintf("%s-nsq-scheduled-task-worker-%d", s, i), queue.NewScheduledTaskQueue, "worker")
		c.AddHandler(nsq.HandlerFunc(scheduledTaskHandler.HandleMessage))
		queue.ConnectConsumer(c)
		consumers = append(consumers, c)
	}

	// wait for Ctrl + C to exit
	ch := make(chan os.Signal, 1)
	signal.Notify(ch, os.Interrupt)
	signal.Notify(ch, syscall.SIGTERM)

	// Block until signal is received
	sig := <-ch

	log.Infof("Stopping the server. OS Signal: %v", sig)

	for _, c := range consumers {
		c.Stop()
	}

	for _, t := range newProductTasks {
		t.Quit()
	}

	for _, t := range scheduledTaskHandlers {
		t.Quit()
	}
}

func MigrateDB(e env.TrakEnv, opts connection.MariaDBConnectOpts) error {
	log.Tracef("loading env: %v", e)
	db, err := connection.GetMariaDB(opts)
	if err != nil {
		log.Errorf("failed to get db connection: %v", err)
		return err
	}
	model.MigrateModels(db)
	connection.CloseMariaDB(db)
	return nil
}

func WorkerTaskFactory(opts connection.MariaDBConnectOpts, trakEnv env.TrakEnv) {
	db, e := connection.GetMariaDB(opts)
	if e != nil {
		log.Fatalf("failed to get db connection: %v", e)
	}

	nsqProducer := queue.CreateNSQProducer()
	defer nsqProducer.Stop()
	ticker := time.NewTicker(10 * time.Second)

	taskProducer := queue.NSQScheduledTaskProducer{
		DB:       db,
		Producer: nsqProducer,
		Ticker:   ticker,
		TrakEnv:  trakEnv,
	}

	taskProducer.Run()
}
