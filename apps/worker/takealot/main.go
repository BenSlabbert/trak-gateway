package main

import (
	"encoding/binary"
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
	"net/http/pprof"
	"os"
	"os/signal"
	"time"
	"trak-gateway/connection"
	"trak-gateway/takealot/env"
	"trak-gateway/takealot/model"
	"trak-gateway/takealot/queue"
)

func ExposePPROF(port int) {
	router := mux.NewRouter()

	router.HandleFunc("/debug/pprof/", pprof.Index)
	router.HandleFunc("/debug/pprof/cmdline", pprof.Cmdline)
	router.HandleFunc("/debug/pprof/profile", pprof.Profile)
	router.HandleFunc("/debug/pprof/symbol", pprof.Symbol)

	router.Handle("/debug/pprof/goroutine", pprof.Handler("goroutine"))
	router.Handle("/debug/pprof/heap", pprof.Handler("heap"))
	router.Handle("/debug/pprof/threadcreate", pprof.Handler("threadcreate"))
	router.Handle("/debug/pprof/block", pprof.Handler("block"))

	go func() {
		err := http.ListenAndServe(fmt.Sprintf(":%d", port), router)
		log.Warnf("failed to serve on port %d: %v", port, err)
	}()
}

func main() {
	verbose := flag.Bool("v", false, "set verbose logging")
	flag.Parse()

	if *verbose {
		log.SetLevel(log.DebugLevel)
	}

	takealotEnv := env.LoadEnv()
	// todo make this configurable (on/off)
	ExposePPROF(takealotEnv.PPROFEnv.PPROFPort)

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
		go CreateProductChanTaskFactory(opts)
	}

	var consumers []*nsq.Consumer
	var newProductTasks []*queue.NSQNewProductTask
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

	var scheduledTasks []*queue.NSQScheduledTask
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

// todo need better name
func CreateProductChanTaskFactory(opts connection.MariaDBConnectOpts) {
	db, e := connection.GetMariaDB(opts)
	if e != nil {
		log.Fatalf("failed to get db connection: %v", e)
	}

	nsqProducer := queue.CreateNSQProducer()
	defer nsqProducer.Stop()
	ticker := time.NewTicker(10 * time.Second)

	for {
		select {
		case <-ticker.C:
			log.Info("creating new creatProduct tasks")
			err := nsqProducer.Ping()
			if err != nil {
				log.Warnf("failed to ping NSQ! No tasks will be produced: %v", err)
				nsqProducer = queue.CreateNSQProducer()
				break
			}

			PublishNewProductTasks(db, nsqProducer)
			PublishPromotionScheduledTask(db, nsqProducer)
		}
	}
}

func PublishPromotionScheduledTask(db *gorm.DB, nsqProducer *nsq.Producer) {
	scheduledTaskModel, ok := model.FindScheduledTaskModelByName(model.PromotionsScheduledTask, db)

	if !ok {
		// create task
		scheduledTaskModel = &model.ScheduledTaskModel{}
		now := time.Now().Add(24 * time.Hour)
		nextRun := time.Date(now.Year(), now.Month(), now.Day(), 10, 0, 0, 0, time.UTC)
		scheduledTaskModel.NextRun = nextRun
		scheduledTaskModel.LastRun = time.Unix(0, 0)
		scheduledTaskModel.Name = model.PromotionsScheduledTask
		_, err := model.UpsertScheduledTaskModel(scheduledTaskModel, db)
		if err != nil {
			log.Warnf("failed to upsert ScheduledTaskModel: %v", err)
			return
		}
	}

	if time.Now().After(scheduledTaskModel.NextRun) {
		log.Infof("running scheduled task: %s", model.PromotionsScheduledTask)
		a := make([]byte, 4)
		binary.LittleEndian.PutUint32(a, uint32(queue.PromotionsScheduledTask))
		err := nsqProducer.Publish(queue.NewScheduledTaskQueue, a)
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

func PublishNewProductTasks(db *gorm.DB, nsqProducer *nsq.Producer) {
	crawler, ok := model.FindCrawlerModelByName("Takealot", db)
	if !ok {
		crawler = &model.CrawlerModel{Name: "Takealot", LastPLID: 41469985}
	}
	count := 0
	for count < 50 {
		crawler.LastPLID++
		a := make([]byte, 4)
		binary.LittleEndian.PutUint32(a, uint32(crawler.LastPLID))
		log.Infof("pushing plID: %d to queue", crawler.LastPLID)
		err := nsqProducer.Publish(queue.NewProductQueue, a)
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
