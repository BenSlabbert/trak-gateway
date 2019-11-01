package main

import (
	"encoding/binary"
	"errors"
	"flag"
	"fmt"
	"github.com/bsm/redislock"
	"github.com/google/uuid"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"os"
	"os/signal"
	"strings"
	"time"
	"trak-gateway/connection"
	"trak-gateway/takealot/api"
	"trak-gateway/takealot/env"
	"trak-gateway/takealot/model"
	"trak-gateway/takealot/queue"
)

// todo replace this
var DB *gorm.DB

func main() {
	verbose := flag.Bool("v", false, "set verbose logging")
	flag.Parse()

	if *verbose {
		log.SetLevel(log.DebugLevel)
	}

	takealotEnv := env.LoadEnv()
	log.Tracef("loading env: %v", takealotEnv)
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
	db, e := connection.GetMariaDB(opts)
	DB = db
	if e != nil {
		log.Errorf("failed to get db connection: %v", e)
		os.Exit(1)
	}

	defer connection.CloseMariaDB(DB)

	model.MigrateModels(DB)

	if takealotEnv.MasterNode {
		go creatProductChanTaskFactory(DB)
	}

	var consumers []*nsq.Consumer
	for i := 0; i < takealotEnv.Nsq.NumberOfNewProductConsumers; i++ {
		s := uuid.New().String()[:6]
		c := queue.CreateNSQConsumer(fmt.Sprintf("%s-nsq-new-product-worker-%d", s, i), queue.NewProductQueue)
		c.AddHandler(nsq.HandlerFunc(HandleNSQNewProductMessage))
		queue.ConnectConsumer(c)
		consumers = append(consumers, c)
	}

	for i := 0; i < takealotEnv.Nsq.NumberOfScheduledTaskConsumers; i++ {
		s := uuid.New().String()[:6]
		c := queue.CreateNSQConsumer(fmt.Sprintf("%s-nsq-scheduled-task-worker-%d", s, i), queue.NewScheduledTaskQueue)
		c.AddHandler(nsq.HandlerFunc(HandleNSQScheduledTaskMessage))
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
}

func creatProductChanTaskFactory(db *gorm.DB) {
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
	var err error

	if !ok {
		// create task
		scheduledTaskModel = &model.ScheduledTaskModel{}
		now := time.Now().Add(24 * time.Hour)
		nextRun := time.Date(now.Year(), now.Month(), now.Day(), 10, 0, 0, 0, time.UTC)
		scheduledTaskModel.NextRun = nextRun
		scheduledTaskModel.LastRun = time.Unix(0, 0)
		scheduledTaskModel.Name = model.PromotionsScheduledTask
		scheduledTaskModel, err = model.UpsertScheduledTaskModel(scheduledTaskModel, db)
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

func PersistProduct(plID uint, productResponse *api.ProductResponse) (uint, error) {
	product := &model.ProductModel{}
	product.PLID = plID
	product.MapResponseToModel(productResponse)
	product, err := model.UpsertProductModel(product, DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return 0, errors.New("failed to persist product entity")
	}

	return product.ID, nil
}

func HandleNSQScheduledTaskMessage(message *nsq.Message) error {
	taskID := binary.LittleEndian.Uint32(message.Body)
	var messageIDBytes []byte
	for _, b := range message.ID {
		messageIDBytes = append(messageIDBytes, b)
	}
	messageID := string(messageIDBytes)

	log.Infof("%s: handling scheduled task", messageID)

	nsqProducer := queue.CreateNSQProducer()
	defer nsqProducer.Stop()

	switch taskID {
	case uint32(queue.PromotionsScheduledTask):
		promotionsResponse, err := api.FetchPromotions()
		if err != nil {
			log.Warnf("%s: failed to fetch promotions: %v", messageID, err)
			return err
		}

		for _, r := range promotionsResponse.Response {
			promotionModel := &model.PromotionModel{}
			promotionModel.PromotionID = r.ID
			promotionModel.End = r.End
			promotionModel.Start = r.Start
			promotionModel.DisplayName = r.ShortDisplayName

			promotionModel, err := model.UpsertPromotionModel(promotionModel, DB)

			if err != nil {
				log.Warn(err.Error())
				return err
			}

			pliDsOnPromotion, err := api.FetchPLIDsOnPromotion(promotionModel.PromotionID)

			if err != nil {
				log.Warn(err.Error())
				return err
			}

			for _, plID := range pliDsOnPromotion {
				a := make([]byte, 4)
				binary.LittleEndian.PutUint32(a, uint32(plID))
				log.Infof("pushing plID: %d to queue", plID)
				err := nsqProducer.Publish(queue.NewProductQueue, a)
				if err != nil {
					log.Warnf("failed to publish to nsq: %v", err)
				}

				err = model.CreateProductPromotionLinkModel(plID, promotionModel.ID, DB)
				if err != nil {
					log.Warn(err.Error())
					return err
				}
			}
		}
	}

	return nil
}

func HandleNSQNewProductMessage(message *nsq.Message) error {
	plID := uint(binary.LittleEndian.Uint32(message.Body))
	var messageIDBytes []byte
	for _, b := range message.ID {
		messageIDBytes = append(messageIDBytes, b)
	}
	messageID := string(messageIDBytes)
	log.Infof("%s: handle create product message for plID: %d messageRetries: %d", messageID, plID, message.Attempts)

	client := connection.CreateRedisClient()
	defer connection.CloseRedisClient(client)

	lockClient := redislock.New(client)
	productResponse, err := api.FetchProduct(plID)

	if err != nil {
		log.Warnf(err.Error())
		return nil
	}

	lock := connection.ObtainRedisLock(lockClient, fmt.Sprintf("plID-%d", plID))
	productID, err := PersistProduct(plID, productResponse)
	if e := connection.ReleaseRedisLock(lock); e != nil {
		log.Warnf("%s: %s", messageID, e.Error())
	}

	if err != nil {
		log.Warn(err.Error())
		return err
	}

	for _, img := range productResponse.Gallery.Images {
		imageModel := &model.ProductImageModel{}
		imageModel.ProductID = productID
		imageModel.URLFormat = img
		imageModel, err := model.CreateProductImageModel(imageModel, DB)

		if err != nil {
			log.Warn(err.Error())
			return err
		}
	}

	price := &model.PriceModel{}
	price.CurrentPrice = productResponse.EventData.Documents.Product.PurchasePrice
	price.ListPrice = productResponse.EventData.Documents.Product.OriginalPrice
	price.ProductID = productID
	price, err = model.CreatePrice(price, DB)
	if err != nil {
		log.Errorf("%s: failed to persist product model!", messageID)
		return err
	}

	if productResponse.Core.Brand != nil {
		lock = connection.ObtainRedisLock(lockClient, fmt.Sprintf("brand-%s", *productResponse.Core.Brand))

		err := PersistBrand(productResponse, productID)
		if e := connection.ReleaseRedisLock(lock); e != nil {
			log.Warnf("%s: %s", messageID, e.Error())
		}
		if err != nil {
			log.Warn(err.Error())
			return err
		}
	}

	categories := make(map[string]string)
	for _, v := range productResponse.ProductInformation.Categories.Value {
		for _, i := range v {
			upper := strings.ToUpper(i.Name)
			categories[upper] = upper
		}
	}

	for _, c := range categories {
		lock = connection.ObtainRedisLock(lockClient, fmt.Sprintf("category-%s", c))
		err := PersistCategory(c, productID)
		if e := connection.ReleaseRedisLock(lock); e != nil {
			log.Warnf("%s: %s", messageID, e.Error())
		}
		if err != nil {
			log.Warn(err.Error())
			return err
		}
	}

	return nil
}

func PersistCategory(category string, productID uint) error {
	categoryModel := &model.CategoryModel{}
	categoryModel.Name = category
	categoryModel, err := model.UpsertCategoryModel(categoryModel, DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return errors.New("failed to persist product entity")
	}
	err = model.CreateProductCategoryLinkModel(productID, categoryModel.ID, DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return errors.New("failed to persist product entity")
	}
	return nil
}

func PersistBrand(productResponse *api.ProductResponse, productID uint) error {
	brand := &model.BrandModel{}
	brand.Name = *productResponse.Core.Brand
	brand, err := model.UpsertBrandModel(brand, DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return errors.New("failed to persist product entity")
	}
	err = model.CreateProductBrandLinkModel(productID, brand.ID, DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return errors.New("failed to persist product entity")
	}
	return nil
}
