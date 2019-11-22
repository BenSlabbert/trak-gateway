package queue

import (
	"github.com/gammazero/workerpool"
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
	case PriceCleanUpScheduledTask.ID:
		go task.handlePriceCleanUpScheduledTask(messageID)
	default:
		log.Warnf("unknown taskID: %d", taskID)
	}

	return nil
}

func (task *NSQScheduledTaskHandler) handlePriceUpdateScheduledTask(messageID string) {
	log.Infof("%s: starting handlePriceUpdateScheduledTask", messageID)
	defer log.Infof("%s: finished handlePriceUpdateScheduledTask", messageID)

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
	log.Infof("%s: starting handlePromotionsScheduledTask", messageID)
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

	log.Infof("%s: finished handlePromotionsScheduledTask", messageID)
}

func (task *NSQScheduledTaskHandler) createPromotionProducts(promotionModel *model.PromotionModel) {
	log.Infof("starting createPromotionProducts promotionID: %d", promotionModel.PromotionID)
	defer log.Info("finished handleBrandUpdateScheduledTask")

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
	log.Infof("%s: starting handleBrandUpdateScheduledTask", messageID)
	defer log.Infof("%s: finished handleBrandUpdateScheduledTask", messageID)

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
				log.Infof("%s: Brand: %s pushing plID: %d to queue", messageID, bm.Name, plID)
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
	log.Infof("%s: starting handleDailyDealPriceUpdateScheduledTask", messageID)
	dailyDealPromotion, ok := model.FindLatestDailyDealPromotion(task.DB)

	if !ok {
		log.Warnf("%s: no Daily Deal promotion available", messageID)
		return
	}

	page := 0
	size := 100
	productModels, queryPage := model.FindProductsByPromotion(dailyDealPromotion.ID, page, size, task.DB)

	for !queryPage.IsLastPage {
		for _, m := range productModels {
			err := task.Producer.Publish(NewProductQueue, SendUintMessage(m.PLID))
			if err != nil {
				log.Errorf("%s: failed to publish plID: %d to nsq: %v", messageID, m.PLID, err)
				return
			}
		}

		page++
		productModels, queryPage = model.FindProductsByPromotion(dailyDealPromotion.ID, page, size, task.DB)
	}

	// run last page
	for _, m := range productModels {
		err := task.Producer.Publish(NewProductQueue, SendUintMessage(m.PLID))
		if err != nil {
			log.Errorf("%s: failed to publish plID: %d to nsq: %v", messageID, m.PLID, err)
			return
		}
	}

	log.Infof("%s: finished handleDailyDealPriceUpdateScheduledTask", messageID)
}

func (task *NSQScheduledTaskHandler) handlePriceCleanUpScheduledTask(messageID string) {
	log.Infof("%s: starting handlePriceCleanUpScheduledTask", messageID)
	errChan := make(chan error)
	defer close(errChan)

	greaterThanID := uint(0)
	size := 1000
	products := model.FindProducts(greaterThanID, size, task.DB)

	for len(products) > 0 {
		pool := workerpool.New(5)

		for _, pm := range products {
			productID := pm.ID
			pool.Submit(func() {
				log.Infof("%s: cleaning prices for productID: %d", messageID, productID)
				err := model.RemoveProductDuplicatePrices(productID, task.DB)
				errChan <- err
			})
		}

		for range products {
			err := <-errChan
			if err != nil {
				log.Errorf("failed to remove product price: %v", err)
			}
		}

		pool.Stop()

		greaterThanID = products[len(products)-1].ID
		products = model.FindProducts(greaterThanID, size, task.DB)
	}

	log.Infof("%s: finished handlePriceCleanUpScheduledTask", messageID)
}
