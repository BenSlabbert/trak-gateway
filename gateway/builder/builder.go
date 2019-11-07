package builder

import (
	"errors"
	"fmt"
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"github.com/jinzhu/gorm"
	log "github.com/sirupsen/logrus"
	"math"
	"trak-gateway/takealot/model"
)

type ProductMessageBuilder struct {
	DB           *gorm.DB
	ID           uint
	ProductModel *model.ProductModel
	msg          *pb.ProductMessage
}

func (pmb *ProductMessageBuilder) categories() {
	categories := make([]*pb.CategoryMessage, 0)
	categoryModels := model.FindProductCategories(pmb.ID, pmb.DB)

	for _, cm := range categoryModels {
		categories = append(categories, &pb.CategoryMessage{
			Id:   int64(cm.ID),
			Name: cm.Name,
		})
	}
	pmb.msg.Categories = categories
}

func (pmb *ProductMessageBuilder) brand() {
	brandModel, ok := model.FindProductBrand(pmb.ID, pmb.DB)
	if !ok {
		log.Warnf("No brand for productID: %d", pmb.ID)
		// todo need sensible default, look in old java code
		brandModel = &model.BrandModel{
			Model: gorm.Model{ID: 0},
			Name:  "UNKNOWN",
		}
	}
	pmb.msg.Brand = &pb.BrandMessage{
		Id:   int64(brandModel.ID),
		Name: brandModel.Name,
	}
}

func (pmb *ProductMessageBuilder) id(p int64) {
	pmb.msg.Id = p
}

func (pmb *ProductMessageBuilder) imageUrl() {
	// todo need sensible default, look in old java code
	imageURL := "0"
	imageModel, ok := model.FindProductImageModel(pmb.ID, pmb.DB)
	if ok {
		imageURL = imageModel.FormatURL(model.ProductImageSizePreview)
	}
	pmb.msg.ImageUrl = imageURL
}

func (pmb *ProductMessageBuilder) productUrl(p string) {
	pmb.msg.ProductUrl = p
}

func (pmb *ProductMessageBuilder) name(p string) {
	pmb.msg.Name = p
}

func (pmb *ProductMessageBuilder) price(p string) {
	pmb.msg.Price = p
}

func (pmb *ProductMessageBuilder) setLatestPrice() {
	price := ""
	priceModel, ok := model.FindProductLatestPrice(pmb.ID, pmb.DB)
	if ok {
		price = fmt.Sprintf("%.2f", priceModel.CurrentPrice)
	}

	pmb.price(price)
}

func (pmb *ProductMessageBuilder) setProductDetails() {
	if pmb.ProductModel == nil {
		productModel, ok := model.FindProductModel(pmb.ID, pmb.DB)
		if !ok {
			panic(fmt.Sprintf("failed to find product with id: %d", pmb.ID))
		}
		pmb.ProductModel = productModel
	}

	pmb.name(pmb.ProductModel.Title)
	pmb.productUrl(pmb.ProductModel.URL)
	pmb.id(int64(pmb.ProductModel.ID))
}

// Build returns a built ProductMessage
func (pmb *ProductMessageBuilder) Build() (msg *pb.ProductMessage, err error) {
	// todo check this recover
	defer func() {
		if r := recover(); r != nil {
			log.Warnf("Recovered in ProductMessageBuilder: %v", r)
			// find out exactly what the error was and set err
			switch x := r.(type) {
			case string:
				err = errors.New(x)
			case error:
				err = x
			default:
				err = errors.New("unknown panic")
			}
			// invalidate rep
			msg = nil
			// return the modified err and rep
		}
	}()

	if pmb.ID == 0 && pmb.ProductModel == nil {
		panic("product model or product ID needs to be set!")
	}

	if pmb.DB == nil {
		panic("no gorm DB instance provided!")
	}

	pmb.msg = &pb.ProductMessage{}
	pmb.setProductDetails()
	pmb.setLatestPrice()
	pmb.imageUrl()
	return pmb.msg, nil
}

type ProductStatsBuilder struct {
	DB        *gorm.DB
	ProductID uint
	msg       *pb.ProductStatsResponse
	prices    []*model.PriceModel
	chartData *pb.ChartDataMessage
	min       float64
	max       float64
	mean      float64
}

func (psb *ProductStatsBuilder) setPriceMinMaxMean() {
	psb.min = math.MaxFloat64
	psb.max = float64(0)
	total := float64(0)
	isFirst := true
	for _, p := range psb.prices {
		if isFirst {
			isFirst = false
			psb.min = p.CurrentPrice
			psb.max = p.CurrentPrice
		}
		total += p.CurrentPrice
		if p.CurrentPrice < psb.min {
			psb.min = p.CurrentPrice
		}

		if p.CurrentPrice > psb.max {
			psb.max = p.CurrentPrice
		}
	}

	psb.mean = total
	if len(psb.prices) > 0 {
		psb.mean = math.Round(total / float64(len(psb.prices)))
	}
}

func (psb *ProductStatsBuilder) setChartData() {
	psb.prices = model.FindProductLatestPrices(psb.ProductID, 0, 30, psb.DB)

	labels := make([]string, 0)
	for _, p := range psb.prices {
		labels = append(labels, p.CreatedAt.String())
	}

	dataSets := make([]*pb.ChartDataSetMessage, 0)

	priceData := make([]int64, 0)
	for _, p := range psb.prices {
		priceData = append(priceData, int64(p.CurrentPrice))
	}

	dataSets = append(dataSets, &pb.ChartDataSetMessage{
		Label:                "current",
		FillColor:            "rgba(220,220,220,0.2)",
		StrokeColor:          "rgba(220,220,220,1)",
		PointColor:           "rgba(220,220,220,1)",
		PointStrokeColor:     "#fff",
		PointHighlightFill:   "#fff",
		PointHighlightStroke: "rgba(220,220,220,1)",
		Data:                 priceData,
	})

	priceData = make([]int64, 0)
	for _, p := range psb.prices {
		priceData = append(priceData, int64(p.ListPrice))
	}

	dataSets = append(dataSets, &pb.ChartDataSetMessage{
		Label:                "listed",
		FillColor:            "rgba(151,187,205,0.2)",
		StrokeColor:          "rgba(151,187,205,0.2)",
		PointColor:           "rgba(151,187,205,1)",
		PointStrokeColor:     "#fff",
		PointHighlightFill:   "#fff",
		PointHighlightStroke: "rgba(151,187,205,1)",
		Data:                 priceData,
	})

	psb.chartData = &pb.ChartDataMessage{
		Labels:   labels,
		DataSets: dataSets,
	}
}

func (psb *ProductStatsBuilder) Build() (msg *pb.ProductStatsResponse, err error) {
	// todo check this recover
	defer func() {
		if r := recover(); r != nil {
			log.Warnf("Recovered in ProductStatsBuilder: %v", r)
			// find out exactly what the error was and set err
			switch x := r.(type) {
			case string:
				err = errors.New(x)
			case error:
				err = x
			default:
				err = errors.New("unknown panic")
			}
			// invalidate rep
			msg = nil
			// return the modified err and rep
		}
	}()

	if psb.ProductID == 0 {
		panic("product message needs to be set!")
	}

	if psb.DB == nil {
		panic("no gorm DB instance provided!")
	}

	psb.setChartData()
	psb.setPriceMinMaxMean()

	return &pb.ProductStatsResponse{
		MinPrice:  int64(psb.min),
		MaxPrice:  int64(psb.max),
		MeanPrice: psb.mean,
		ChartData: psb.chartData,
	}, nil
}
