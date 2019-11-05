package queue

import (
	"encoding/binary"
	"errors"
	"fmt"
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"github.com/bsm/redislock"

	"github.com/golang/protobuf/proto"
	"github.com/jinzhu/gorm"
	"github.com/nsqio/go-nsq"
	"github.com/prometheus/common/log"
	"strings"
	"trak-gateway/connection"
	"trak-gateway/takealot/api"
	"trak-gateway/takealot/model"
)

type NSQNewProductTask struct {
	DB         *gorm.DB
	LockClient *redislock.Client
	Producer   *nsq.Producer
}

func (task *NSQNewProductTask) Quit() {
	connection.CloseMariaDB(task.DB)
	task.Producer.Stop()
}

func (task *NSQNewProductTask) HandleMessage(message *nsq.Message) error {
	plID := uint(binary.LittleEndian.Uint32(message.Body))
	var messageIDBytes []byte
	for _, b := range message.ID {
		messageIDBytes = append(messageIDBytes, b)
	}
	messageID := string(messageIDBytes)
	log.Infof("%s: handle create product message for plID: %d messageRetries: %d", messageID, plID, message.Attempts)

	productResponse, err := api.FetchProduct(plID)

	if err != nil {
		log.Warnf(err.Error())
		return nil
	}

	lock, err := connection.ObtainRedisLock(task.LockClient, fmt.Sprintf("plID-%d", plID))
	if err != nil {
		log.Warn(err.Error())
		return err
	}

	productID, err := task.persistProduct(plID, productResponse)
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
		imageModel, err := model.CreateProductImageModel(imageModel, task.DB)

		if err != nil {
			log.Warn(err.Error())
			return err
		}
	}

	price := &model.PriceModel{}
	price.CurrentPrice = productResponse.EventData.Documents.Product.PurchasePrice
	price.ListPrice = productResponse.EventData.Documents.Product.OriginalPrice
	price.ProductID = productID
	price, err = model.CreatePrice(price, task.DB)
	if err != nil {
		log.Errorf("%s: failed to persist product model!", messageID)
		return err
	}

	if productResponse.Core.Brand != nil {
		lock, err = connection.ObtainRedisLock(task.LockClient, fmt.Sprintf("brand-%s", *productResponse.Core.Brand))
		if err != nil {
			log.Warn(err.Error())
			return err
		}

		err := task.persistBrand(productResponse, productID)
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
		lock, err = connection.ObtainRedisLock(task.LockClient, fmt.Sprintf("category-%s", c))
		if err != nil {
			log.Warn(err.Error())
			return err
		}

		err := task.persistCategory(c, productID)
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

func (task *NSQNewProductTask) persistProduct(plID uint, productResponse *api.ProductResponse) (uint, error) {
	product := &model.ProductModel{}
	product.PLID = plID
	product.MapResponseToModel(productResponse)
	product, err := model.UpsertProductModel(product, task.DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return 0, errors.New("failed to persist product entity")
	}

	sr := &pb.SearchResult{Id: fmt.Sprintf("%d", product.ID), Name: product.Title}

	if bytes, err := proto.Marshal(sr); err == nil {
		err := task.Producer.Publish(ProductDigestQueue, bytes)
		if err != nil {
			log.Warnf("failed to publish to nsq: %v", err)
		}
	}

	return product.ID, nil
}

func (task *NSQNewProductTask) persistCategory(category string, productID uint) error {
	categoryModel := &model.CategoryModel{}
	categoryModel.Name = category
	categoryModel, err := model.UpsertCategoryModel(categoryModel, task.DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return errors.New("failed to persist product entity")
	}
	err = model.CreateProductCategoryLinkModel(productID, categoryModel.ID, task.DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return errors.New("failed to persist product entity")
	}
	return nil
}

func (task *NSQNewProductTask) persistBrand(productResponse *api.ProductResponse, productID uint) error {
	brand := &model.BrandModel{}
	brand.Name = *productResponse.Core.Brand
	brand, err := model.UpsertBrandModel(brand, task.DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return errors.New("failed to persist product entity")
	}
	err = model.CreateProductBrandLinkModel(productID, brand.ID, task.DB)
	if err != nil {
		log.Error("failed to persist product model!")
		return errors.New("failed to persist product entity")
	}
	return nil
}
