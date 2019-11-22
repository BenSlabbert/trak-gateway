package queue

import (
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"os"
	"testing"
	"trak-gateway/takealot/model"
	tu "trak-gateway/test_utils"
)

// set up test infrastructure for all tests in this package
func TestMain(m *testing.M) {
	nsqCtx, nsqC := tu.SetUpNSQ()
	defer tu.Terminate(nsqCtx, nsqC)

	mariadbCtx, mariadbC := tu.SetUpMariaDB("../../test_utils/trak.sql")
	defer tu.Terminate(mariadbCtx, mariadbC)

	os.Exit(m.Run())
}

type TestHandler struct {
	t *testing.T
}

func (th *TestHandler) HandleMessage(message *nsq.Message) error {
	log.Info("got nsq message")
	plID := ReceiveUintMessage(message.Body)
	if !(plID == 32846180 || plID == 53598059 || plID == 54542371 || plID == 51858001) {
		th.t.Errorf("incorrect plID: %d", plID)
	}
	return nil
}

func TestNSQScheduledTaskHandler_HandleDailyDealPriceUpdateScheduledTask(t *testing.T) {
	log.Info("starting TestNSQScheduledTaskHandler_HandleDailyDealPriceUpdateScheduledTask")

	th := &TestHandler{t: t}
	consumer := tu.GetNSQConsumer("test-client", NewProductQueue, "test-worker", t)
	consumer.AddHandler(nsq.HandlerFunc(th.HandleMessage))
	tu.NSQConsumerConnect(consumer, t)

	handler := NSQScheduledTaskHandler{
		DB:       tu.GetDB(t),
		Producer: tu.GetNSQProducer(t),
	}

	handler.handleDailyDealPriceUpdateScheduledTask("messageID")
}

func TestNSQScheduledTaskHandler_HandlePriceCleanUpScheduledTask(t *testing.T) {
	db := tu.GetDB(t)

	prices := model.FindProductLatestPrices(1, 0, 100, db)

	if len(prices) != 17 {
		t.Error("should find 3 prices")
	}

	if prices[0].CurrentPrice != 2.0 {
		t.Errorf("%f should equal: %f", prices[0].CurrentPrice, 2.0)
	}

	if prices[1].CurrentPrice != 1.0 {
		t.Errorf("%f should equal: %f", prices[0].CurrentPrice, 1.0)
	}

	if prices[2].CurrentPrice != 1.0 {
		t.Errorf("%f should equal: %f", prices[0].CurrentPrice, 1.0)
	}

	handler := NSQScheduledTaskHandler{
		DB:       db,
		Producer: nil,
	}

	handler.handlePriceCleanUpScheduledTask("messageID")

	prices = model.FindProductLatestPrices(1, 0, 100, db)

	if len(prices) != 16 {
		t.Error("should find 16 prices")
	}

	if prices[0].CurrentPrice != 2.0 {
		t.Errorf("%f should equal: %f", prices[0].CurrentPrice, 2.0)
	}

	if prices[1].CurrentPrice != 1.0 {
		t.Errorf("%f should equal: %f", prices[0].CurrentPrice, 1.0)
	}

	if prices[2].CurrentPrice != 3.0 {
		t.Errorf("%f should equal: %f", prices[0].CurrentPrice, 3.0)
	}
}
