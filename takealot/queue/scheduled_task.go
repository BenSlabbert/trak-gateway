package queue

import (
	"encoding/binary"
	"github.com/jinzhu/gorm"
	"github.com/nsqio/go-nsq"
	"github.com/prometheus/common/log"
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
	taskID := binary.LittleEndian.Uint32(message.Body)
	var messageIDBytes []byte
	for _, b := range message.ID {
		messageIDBytes = append(messageIDBytes, b)
	}
	messageID := string(messageIDBytes)

	log.Infof("%s: handling scheduled task", messageID)

	switch taskID {
	case uint32(PromotionsScheduledTask):
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

			promotionModel, err := model.UpsertPromotionModel(promotionModel, task.DB)

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
				err := task.Producer.Publish(NewProductQueue, a)
				if err != nil {
					log.Warnf("failed to publish to nsq: %v", err)
				}

				err = model.CreateProductPromotionLinkModel(plID, promotionModel.ID, task.DB)
				if err != nil {
					log.Warn(err.Error())
					return err
				}
			}
		}
	}

	return nil
}
