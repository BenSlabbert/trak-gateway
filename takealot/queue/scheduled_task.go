package queue

import (
	"github.com/jinzhu/gorm"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"trak-gateway/connection"
	"trak-gateway/takealot/api"
	"trak-gateway/takealot/model"
)

type NSQScheduledTask struct {
	DB       *gorm.DB
	Producer *nsq.Producer
}

func (task *NSQScheduledTask) Quit() {
	connection.CloseMariaDB(task.DB)
	task.Producer.Stop()
}

func (task *NSQScheduledTask) HandleMessage(message *nsq.Message) error {
	taskID := ReceiveUintMessage(message.Body)
	messageID := MessageIDString(message.ID)

	log.Infof("%s: handling scheduled task", messageID)

	switch taskID {
	case uint(PromotionsScheduledTask):
		go task.handlePromotionsScheduledTask(messageID)
	case uint(PriceUpdateScheduledTask):
		go task.handlePriceUpdateScheduledTask(messageID)
	default:
		log.Warnf("unknown taskID: %d", taskID)
	}

	return nil
}

func (task *NSQScheduledTask) handlePriceUpdateScheduledTask(messageID string) {
	greaterThanID := uint(0)
	size := 1000

	for {
		log.Infof("%s: getting %d products greater than ID %d from the db", messageID, size, greaterThanID)
		productModels := model.FindProducts(greaterThanID, size, task.DB)

		if len(productModels) == 0 {
			log.Infof("%s: no more products to update", messageID)
			return
		}

		for _, pm := range productModels {
			e := task.Producer.Publish(NewProductQueue, SendUintMessage(pm.PLID))
			if e != nil {
				log.Warnf("%s: failed to publish to queue: %s exiting handlePriceUpdateScheduledTask: %v", messageID, NewProductQueue, e)
				return
			}
		}

		greaterThanID = productModels[len(productModels)-1].ID
	}
}

func (task *NSQScheduledTask) handlePromotionsScheduledTask(messageID string) {
	promotionsResponse, err := api.FetchPromotions()

	if err != nil {
		log.Warnf("%s: failed to fetch promotions: %v", messageID, err)
		return
	}

	promotions := make([]*model.PromotionModel, 0)

	for _, r := range promotionsResponse.Response {
		pm := &model.PromotionModel{}
		pm.PromotionID = r.ID
		pm.End = r.End
		pm.Start = r.Start
		pm.DisplayName = r.ShortDisplayName

		pm, err = model.UpsertPromotionModel(pm, task.DB)

		if err != nil {
			log.Warn(err.Error())
			return
		}
		promotions = append(promotions, pm)
	}

	for _, promotionModel := range promotions {
		promotionModel := promotionModel
		go task.createPromotionProducts(promotionModel)
	}
}

func (task *NSQScheduledTask) createPromotionProducts(promotionModel *model.PromotionModel) {
	log.Infof("createPromotionProducts promotionID: %d", promotionModel.PromotionID)

	pliDsOnPromotion, err := api.FetchPLIDsOnPromotion(promotionModel.PromotionID)
	if err != nil {
		log.Warn(err.Error())
		return
	}
	for _, plID := range pliDsOnPromotion {
		log.Infof("pushing plID: %d to queue", plID)
		err := task.Producer.Publish(NewProductQueue, SendUintMessage(plID))
		if err != nil {
			log.Warnf("failed to publish to nsq: %v", err)
		}
		err = model.CreateProductPromotionLinkModel(plID, promotionModel.ID, task.DB)
		if err != nil {
			log.Warn(err.Error())
			return
		}
	}
}
