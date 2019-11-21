package queue

import (
	"encoding/binary"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"strings"
	"time"
	"trak-gateway/takealot/env"
)

const NewScheduledTaskQueue string = "new-scheduled-task-queue"
const CategoryDigestQueue string = "category-digest-queue"
const ProductDigestQueue string = "product-digest-queue"
const BrandDigestQueue string = "brand-digest-queue"
const NewProductQueue string = "new-product-queue"

type ScheduledTask struct {
	ID uint
}

func (st *ScheduledTask) FirstRun() time.Time {
	switch st.ID {
	case PromotionsScheduledTaskID:
		now := time.Now().Add(24 * time.Hour)
		return time.Date(now.Year(), now.Month(), now.Day()-2, 7, 0, 0, 0, time.UTC)
	case PriceUpdateScheduledTaskTaskID:
		now := time.Now().Add(24 * time.Hour)
		return time.Date(now.Year(), now.Month(), now.Day()-2, 7, 0, 0, 0, time.UTC)
	case BrandUpdateScheduledTaskTaskID:
		now := time.Now().Add(2 * time.Hour)
		return time.Date(now.Year(), now.Month(), now.Day()-2, now.Hour(), 0, 0, 0, time.UTC)
	case DailyDealPriceUpdateScheduledTaskTaskID:
		now := time.Now().Add(1 * time.Hour)
		return time.Date(now.Year(), now.Month(), now.Day()-2, now.Hour(), 0, 0, 0, time.UTC)
	}
	return time.Now()
}

func (st *ScheduledTask) NextRun() time.Time {
	switch st.ID {
	case PromotionsScheduledTaskID:
		now := time.Now().Add(24 * time.Hour)
		return time.Date(now.Year(), now.Month(), now.Day(), 7, 0, 0, 0, time.UTC)
	case PriceUpdateScheduledTaskTaskID:
		now := time.Now().Add(24 * time.Hour)
		return time.Date(now.Year(), now.Month(), now.Day(), 7, 0, 0, 0, time.UTC)
	case BrandUpdateScheduledTaskTaskID:
		now := time.Now().Add(2 * time.Hour)
		return time.Date(now.Year(), now.Month(), now.Day(), now.Hour(), 0, 0, 0, time.UTC)
	case DailyDealPriceUpdateScheduledTaskTaskID:
		now := time.Now().Add(1 * time.Hour)
		return time.Date(now.Year(), now.Month(), now.Day(), now.Hour(), 0, 0, 0, time.UTC)
	}
	return time.Now()
}

const PromotionsScheduledTaskID uint = 1
const PriceUpdateScheduledTaskTaskID uint = 2
const BrandUpdateScheduledTaskTaskID uint = 3
const DailyDealPriceUpdateScheduledTaskTaskID uint = 4

// PromotionsScheduledTask const, do not modify
var PromotionsScheduledTask = &ScheduledTask{ID: PromotionsScheduledTaskID}

// PriceUpdateScheduledTask const, do not modify
var PriceUpdateScheduledTask = &ScheduledTask{ID: PriceUpdateScheduledTaskTaskID}

// BrandUpdateScheduledTask const, do not modify
var BrandUpdateScheduledTask = &ScheduledTask{ID: BrandUpdateScheduledTaskTaskID}

// DailyDealPriceUpdateScheduledTask const, do not modify
var DailyDealPriceUpdateScheduledTask = &ScheduledTask{ID: DailyDealPriceUpdateScheduledTaskTaskID}

func ConnectConsumer(consumer *nsq.Consumer) {
	nsqEnv := env.LoadEnv().Nsq

	// use this when connecting to nsqlookupd, does not work for producers
	//err := consumer.ConnectToNSQLookupd(nsqEnv.NsqdURL)
	err := consumer.ConnectToNSQD(nsqEnv.NsqdURL)
	if err != nil {
		log.Panicf("could not connect: %v", err)
	}
	log.Println("connected to NSQ")
}

type NsqLogger struct {
}

func (l *NsqLogger) Output(calldepth int, s string) error {
	if strings.HasPrefix(s, "INF") {
		index := strings.Index(s, "[")
		log.Info(s[index:])
	} else if strings.HasPrefix(s, "WRN") {
		index := strings.Index(s, "[")
		log.Info(s[index:])
	}
	return nil
}

func CreateNSQConsumer(clientID, topic, channel string) *nsq.Consumer {
	validChannelName := nsq.IsValidChannelName(channel)
	if !validChannelName {
		log.Fatalf("invalid channel name: %s", channel)
	}
	config := nsq.NewConfig()
	config.ClientID = clientID
	consumer, _ := nsq.NewConsumer(topic, channel, config)
	consumer.SetLogger(&NsqLogger{}, nsq.LogLevelInfo)
	return consumer
}

func CreateNSQProducer() *nsq.Producer {
	e := env.LoadEnv()
	config := nsq.NewConfig()
	producer, _ := nsq.NewProducer(e.Nsq.NsqdURL, config)
	return producer
}

func SendUintMessage(message uint) []byte {
	a := make([]byte, 4)
	binary.LittleEndian.PutUint32(a, uint32(message))
	return a
}

func ReceiveUintMessage(message []byte) uint {
	u := binary.LittleEndian.Uint32(message)
	return uint(u)
}

func MessageIDString(messageID nsq.MessageID) string {
	messageIDBytes := make([]byte, 0)
	for _, b := range messageID {
		messageIDBytes = append(messageIDBytes, b)
	}
	return string(messageIDBytes)
}
