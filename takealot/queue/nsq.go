package queue

import (
	"encoding/binary"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"strings"
	"trak-gateway/takealot/env"
)

const NewScheduledTaskQueue string = "new-scheduled-task-queue"
const NewProductQueue string = "new-product-queue"
const ProductDigestQueue string = "product-digest-queue"
const BrandDigestQueue string = "brand-digest-queue"
const CategoryDigestQueue string = "category-digest-queue"

type ScheduledTask uint

const PromotionsScheduledTask ScheduledTask = 1
const PriceUpdateScheduledTask ScheduledTask = 2
const BrandUpdateScheduledTask ScheduledTask = 3

func ConnectConsumer(consumer *nsq.Consumer) {
	e := env.LoadEnv()
	err := consumer.ConnectToNSQD(e.Nsq.NsqdURL)
	if err != nil {
		log.Panic("could not connect")
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
