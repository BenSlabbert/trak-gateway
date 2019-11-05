package queue

import (
	"github.com/nsqio/go-nsq"
	"log"
	"trak-gateway/takealot/env"
)

const NewScheduledTaskQueue string = "new-scheduled-task-queue"
const NewProductQueue string = "new-product-queue"
const ProductDigestQueue string = "product-digest-queue"

type ScheduledTask uint32

const PromotionsScheduledTask ScheduledTask = 1

func ConnectConsumer(consumer *nsq.Consumer) {
	e := env.LoadEnv()
	err := consumer.ConnectToNSQD(e.Nsq.NsqdURL)
	if err != nil {
		log.Panic("could not connect")
	}
	log.Println("connected to NSQ")
}

func CreateNSQConsumer(clientID, topic, channel string) *nsq.Consumer {
	validChannelName := nsq.IsValidChannelName(channel)
	if !validChannelName {
		log.Fatalf("invalid channel name: %s", channel)
	}
	config := nsq.NewConfig()
	config.ClientID = clientID
	consumer, _ := nsq.NewConsumer(topic, channel, config)
	return consumer
}

func CreateNSQProducer() *nsq.Producer {
	e := env.LoadEnv()
	config := nsq.NewConfig()
	producer, _ := nsq.NewProducer(e.Nsq.NsqdURL, config)
	return producer
}
