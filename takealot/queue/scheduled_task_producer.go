package queue

import (
	"github.com/jinzhu/gorm"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"time"
	"trak-gateway/takealot/env"
	"trak-gateway/takealot/model"
)

type NSQScheduledTaskProducer struct {
	DB       *gorm.DB
	Producer *nsq.Producer
	Ticker   *time.Ticker
	TrakEnv  env.TrakEnv
}

func (p *NSQScheduledTaskProducer) Run() {
	for range p.Ticker.C {
		err := p.Producer.Ping()
		if err != nil {
			log.Warnf("failed to ping NSQ! No tasks will be produced: %v", err)
			p.Producer = CreateNSQProducer()
		}

		p.crawlerPublishNewProductTasks()
		p.publishScheduledTask(model.BrandUpdateScheduledTaskName, NewScheduledTaskQueue, BrandUpdateScheduledTask)
		p.publishScheduledTask(model.PriceUpdateScheduledTaskName, NewScheduledTaskQueue, PriceUpdateScheduledTask)
		p.publishScheduledTask(model.PromotionsScheduledTaskName, NewScheduledTaskQueue, PromotionsScheduledTask)
		p.publishScheduledTask(model.DailyDealPriceUpdateScheduledTaskName, NewScheduledTaskQueue, DailyDealPriceUpdateScheduledTask)
		p.publishScheduledTask(model.PriceCleanUpScheduledTaskName, NewScheduledTaskQueue, PriceCleanUpScheduledTask)
	}
}

func (p *NSQScheduledTaskProducer) crawlerPublishNewProductTasks() {
	if !p.TrakEnv.Crawler.Enabled {
		log.Info("crawler not enabled")
		return
	}

	crawler, ok := model.FindCrawlerModelByName("Takealot", p.DB)
	if !ok {
		crawler = &model.CrawlerModel{Name: "Takealot", LastPLID: p.TrakEnv.Crawler.TakealotInitialPLID}
	}

	count := 0
	for count < p.TrakEnv.Crawler.NumberOfNewProductTasks {
		crawler.LastPLID++
		log.Infof("NewProductTasks: pushing plID: %d to queue", crawler.LastPLID)
		err := p.Producer.Publish(NewProductQueue, SendUintMessage(crawler.LastPLID))
		if err != nil {
			log.Warnf("failed to publish to nsq: %v", err)
		}
		count++
	}

	_, err := model.UpserCrawlerModel(crawler, p.DB)
	if err != nil {
		log.Warnf("failed to upsert takealot crawler: %v", err)
	}
}

func (p *NSQScheduledTaskProducer) publishScheduledTask(taskName string, taskQueue string, task *ScheduledTask) {
	stm, ok := model.FindScheduledTaskModelByName(taskName, p.DB)

	if !ok {
		// create task
		stm = &model.ScheduledTaskModel{}
		stm.NextRun = task.FirstRun()
		stm.LastRun = time.Now().UTC()
		stm.Name = taskName
		_, err := model.UpsertScheduledTaskModel(stm, p.DB)
		if err != nil {
			log.Warnf("failed to upsert ScheduledTaskModel: %v", err)
			return
		}
	}

	if time.Now().UTC().After(stm.NextRun) {
		// run task
		log.Infof("running scheduled task: %s", taskName)
		err := p.Producer.Publish(taskQueue, SendUintMessage(task.ID))
		if err != nil {
			log.Warnf("failed to publish to nsq: %v", err)
			return
		}

		stm.LastRun = time.Now().UTC()
		stm.NextRun = task.NextRun()
		_, err = model.UpsertScheduledTaskModel(stm, p.DB)
		if err != nil {
			log.Warnf("failed to upsert ScheduledTaskModel: %v", err)
		}
	}
}
