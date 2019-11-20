package main

import (
	"flag"
	"fmt"
	"github.com/bsm/redislock"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
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

	scheduledTasks := make([]*queue.NSQScheduledTask, 0)
	for i := 0; i < takealotEnv.Nsq.NumberOfScheduledTaskConsumers; i++ {
		db, e := connection.GetMariaDB(opts)
		if e != nil {
			log.Fatalf("failed to get db connection: %v", e)
		}
		scheduledTask := &queue.NSQScheduledTask{DB: db, Producer: queue.CreateNSQProducer()}
		scheduledTasks = append(scheduledTasks, scheduledTask)
		s := uuid.New().String()[:6]
		c := queue.CreateNSQConsumer(fmt.Sprintf("%s-nsq-scheduled-task-worker-%d", s, i), queue.NewScheduledTaskQueue, "worker")
		c.AddHandler(nsq.HandlerFunc(scheduledTask.HandleMessage))
		queue.ConnectConsumer(c)
		consumers = append(consumers, c)
	}

	// wait for Ctrl + C to exit
	ch := make(chan os.Signal, 1)
	signal.Notify(ch, os.Interrupt)
	signal.Notify(ch, syscall.SIGTERM)

	// Block until signal is received
	<-ch

	for _, c := range consumers {
		c.Stop()
	}

	for _, t := range newProductTasks {
		t.Quit()
	}

	for _, t := range scheduledTasks {
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

	for range ticker.C {
		err := nsqProducer.Ping()
		if err != nil {
			log.Warnf("failed to ping NSQ! No tasks will be produced: %v", err)
			nsqProducer = queue.CreateNSQProducer()
		}

		PublishNewProductTasks(db, nsqProducer, trakEnv.Crawler)
		PublishPromotionScheduledTask(db, nsqProducer)
		PublishPriceUpdateScheduledTask(db, nsqProducer)
		PublishBrandUpdateScheduledTask(db, nsqProducer)
	}
}

func PublishBrandUpdateScheduledTask(db *gorm.DB, nsqProducer *nsq.Producer) {
	taskName := model.BrandUpdateScheduledTask
	taskQueue := queue.NewScheduledTaskQueue
	scheduledTask := queue.BrandUpdateScheduledTask
	PublishScheduledTask(taskName, taskQueue, scheduledTask, db, nsqProducer)
}

func PublishPriceUpdateScheduledTask(db *gorm.DB, nsqProducer *nsq.Producer) {
	taskName := model.PriceUpdateScheduledTask
	taskQueue := queue.NewScheduledTaskQueue
	scheduledTask := queue.PriceUpdateScheduledTask
	PublishScheduledTask(taskName, taskQueue, scheduledTask, db, nsqProducer)
}

func PublishPromotionScheduledTask(db *gorm.DB, nsqProducer *nsq.Producer) {
	taskName := model.PromotionsScheduledTask
	taskQueue := queue.NewScheduledTaskQueue
	scheduledTask := queue.PromotionsScheduledTask
	PublishScheduledTask(taskName, taskQueue, scheduledTask, db, nsqProducer)
}

func PublishScheduledTask(taskName string, taskQueue string, scheduledTask queue.ScheduledTask, db *gorm.DB, nsqProducer *nsq.Producer) {
	scheduledTaskModel, ok := model.FindScheduledTaskModelByName(taskName, db)

	if !ok {
		// create task
		scheduledTaskModel = &model.ScheduledTaskModel{}
		now := time.Now().Add(24 * time.Hour)
		nextRun := time.Date(now.Year(), now.Month(), now.Day()-2, 10, 0, 0, 0, time.UTC)
		scheduledTaskModel.NextRun = nextRun
		scheduledTaskModel.LastRun = time.Unix(0, 0)
		scheduledTaskModel.Name = taskName
		_, err := model.UpsertScheduledTaskModel(scheduledTaskModel, db)
		if err != nil {
			log.Warnf("failed to upsert ScheduledTaskModel: %v", err)
			return
		}
	}

	if time.Now().After(scheduledTaskModel.NextRun) {
		log.Infof("running scheduled task: %s", taskName)
		err := nsqProducer.Publish(taskQueue, queue.SendUintMessage(uint(scheduledTask)))
		if err != nil {
			log.Warnf("failed to publish to nsq: %v", err)
		} else {
			scheduledTaskModel.LastRun = time.Now()
			now := time.Now().Add(24 * time.Hour)
			nextRun := time.Date(now.Year(), now.Month(), now.Day(), 10, 0, 0, 0, time.UTC)
			scheduledTaskModel.NextRun = nextRun
			_, err := model.UpsertScheduledTaskModel(scheduledTaskModel, db)
			if err != nil {
				log.Warnf("failed to upsert ScheduledTaskModel: %v", err)
			}
		}
	}
}

func PublishNewProductTasks(db *gorm.DB, nsqProducer *nsq.Producer, crawlerEnv env.Crawler) {
	if !crawlerEnv.Enabled {
		log.Info("crawler not enabled")
		return
	}

	crawler, ok := model.FindCrawlerModelByName("Takealot", db)
	if !ok {
		crawler = &model.CrawlerModel{Name: "Takealot", LastPLID: crawlerEnv.TakealotInitialPLID}
	}

	count := 0
	for count < crawlerEnv.NumberOfNewProductTasks {
		crawler.LastPLID++
		log.Infof("NewProductTasks: pushing plID: %d to queue", crawler.LastPLID)
		err := nsqProducer.Publish(queue.NewProductQueue, queue.SendUintMessage(crawler.LastPLID))
		if err != nil {
			log.Warnf("failed to publish to nsq: %v", err)
		}
		count++
	}

	_, err := model.UpserCrawlerModel(crawler, db)
	if err != nil {
		log.Warnf("failed to upsert takealot crawler: %v", err)
	}
}
