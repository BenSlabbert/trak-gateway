package queue

import (
	"github.com/jinzhu/gorm"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"trak-gateway/connection"
	"trak-gateway/takealot/api"
	"trak-gateway/takealot/model"
)

type NSQScheduledTaskHandler struct {
	DB       *gorm.DB
	Producer *nsq.Producer
}

func (task *NSQScheduledTaskHandler) Quit() {
	connection.CloseMariaDB(task.DB)
	task.Producer.Stop()
}

func (task *NSQScheduledTaskHandler) HandleMessage(message *nsq.Message) error {
	taskID := ReceiveUintMessage(message.Body)
	messageID := MessageIDString(message.ID)

	log.Infof("%s: handling scheduled task", messageID)

	// we dont want to flood the queue with these
	if message.Attempts > 2 {
		log.Warnf("%s: too many scheduled task attempts: %d, will not try again", messageID, message.Attempts)
		return nil
	}

	if message.Attempts > 1 {
		log.Warnf("%s: scheduled task multiple attempts: %d", messageID, message.Attempts)
	}

	switch taskID {
	case PromotionsScheduledTask.ID:
		go task.handlePromotionsScheduledTask(messageID)
	case PriceUpdateScheduledTask.ID:
		go task.handlePriceUpdateScheduledTask(messageID)
	case BrandUpdateScheduledTask.ID:
		go task.handleBrandUpdateScheduledTask(messageID)
	case DailyDealPriceUpdateScheduledTask.ID:
		go task.handleDailyDealPriceUpdateScheduledTask(messageID)
	default:
		log.Warnf("unknown taskID: %d", taskID)
	}

	return nil
}

func (task *NSQScheduledTaskHandler) handlePriceUpdateScheduledTask(messageID string) {
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

func (task *NSQScheduledTaskHandler) handlePromotionsScheduledTask(messageID string) {
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

func (task *NSQScheduledTaskHandler) createPromotionProducts(promotionModel *model.PromotionModel) {
	log.Infof("createPromotionProducts promotionID: %d", promotionModel.PromotionID)

	pliDsOnPromotion, err := api.FetchPLIDsOnPromotion(promotionModel.PromotionID)
	if err != nil {
		log.Warn(err.Error())
		return
	}
	for _, plID := range pliDsOnPromotion {
		log.Infof("Promotion: %s promotionID: %d pushing plID: %d to queue", promotionModel.DisplayName, promotionModel.PromotionID, plID)
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

func (task *NSQScheduledTaskHandler) handleBrandUpdateScheduledTask(messageID string) {
	greaterThanID := uint(0)
	size := 1000

	for {
		log.Infof("%s: getting %d products greater than ID %d from the db", messageID, size, greaterThanID)
		brandModels := model.FindBrands(greaterThanID, size, task.DB)

		if len(brandModels) == 0 {
			log.Infof("%s: no more brands to update", messageID)
			return
		}

		// todo run in goroutines
		// get all products associated with the brand
		for _, bm := range brandModels {
			if bm.Name == model.UnknownBrand {
				continue
			}

			pliDs, err := api.FetchBrandPLIDs(bm.Name)
			if err != nil {
				log.Warn(err.Error())
				return
			}

			for _, plID := range pliDs {
				log.Infof("%s: Brand: %s updating plID: %d to queue", messageID, bm.Name, plID)
				err := task.Producer.Publish(NewProductQueue, SendUintMessage(plID))
				if err != nil {
					log.Warnf("%s: failed to publish to nsq: %v", messageID, err)
				}
			}
		}

		greaterThanID = brandModels[len(brandModels)-1].ID
	}
}

func (task *NSQScheduledTaskHandler) handleDailyDealPriceUpdateScheduledTask(messageID string) {
	dailyDealPromotion, ok := model.FindLatestDailyDealPromotion(task.DB)

	if !ok {
		log.Warnf("%s: no Daily Deal promotion available", messageID)
		return
	}

	page := 0
	size := 100
	models, queryPage := model.FindProductsByPromotion(dailyDealPromotion.ID, page, size, task.DB)

	for !queryPage.IsLastPage {
		// todo run in goroutines
		for _, m := range models {
			err := task.Producer.Publish(NewProductQueue, SendUintMessage(m.PLID))
			if err != nil {
				log.Errorf("%s: failed to publish plID: %d to nsq: %v", messageID, m.PLID, err)
				return
			}
		}

		page++
		models, queryPage = model.FindProductsByPromotion(dailyDealPromotion.ID, page, size, task.DB)
	}

	// run last page
	for _, m := range models {
		err := task.Producer.Publish(NewProductQueue, SendUintMessage(m.PLID))
		if err != nil {
			log.Errorf("%s: failed to publish plID: %d to nsq: %v", messageID, m.PLID, err)
			return
		}
	}
}
