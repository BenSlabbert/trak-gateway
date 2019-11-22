package builder

import (
	"errors"
	"fmt"
	pb "github.com/BenSlabbert/trak-gRPC/gen/go/proto/gateway"
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
			Id:   uint32(cm.ID),
			Name: cm.Name,
		})
	}
	pmb.msg.Categories = categories
}

func (pmb *ProductMessageBuilder) brand() {
	brandModel, ok := model.FindProductBrand(pmb.ID, pmb.DB)
	if !ok {
		log.Warnf("No brand for productID: %d", pmb.ID)
		brandModel = model.FindDefaultBrand(pmb.DB)
	}
	pmb.msg.Brand = &pb.BrandMessage{
		Id:   uint32(brandModel.ID),
		Name: brandModel.Name,
	}
}

func (pmb *ProductMessageBuilder) id(p uint32) {
	pmb.msg.Id = p
}

func (pmb *ProductMessageBuilder) imageUrl() {
	imageURL := "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iMTg4IiBoZWlnaHQ9IjIyNiIgdmlld0JveD0iMCAwIDE4OCAyMjYiPgogICAgPGRlZnM+CiAgICAgICAgPHBhdGggaWQ9ImEiIGQ9Ik0wIDBoMTMxLjI0MkwxODggNjB2MTY2SDBWMHoiLz4KICAgICAgICA8bWFzayBpZD0iYyIgd2lkdGg9IjE4OCIgaGVpZ2h0PSIyMjYiIHg9IjAiIHk9IjAiIGZpbGw9IiNmZmYiPgogICAgICAgICAgICA8dXNlIHhsaW5rOmhyZWY9IiNhIi8+CiAgICAgICAgPC9tYXNrPgogICAgICAgIDxwYXRoIGlkPSJiIiBkPSJNMTg1LjY1IDEwaC43djY3aC02NXYtNS42MzEiLz4KICAgICAgICA8bWFzayBpZD0iZCIgd2lkdGg9IjY1IiBoZWlnaHQ9IjY3IiB4PSIwIiB5PSIwIiBmaWxsPSIjZmZmIj4KICAgICAgICAgICAgPHVzZSB4bGluazpocmVmPSIjYiIvPgogICAgICAgIDwvbWFzaz4KICAgIDwvZGVmcz4KICAgIDxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+CiAgICAgICAgPHVzZSBzdHJva2U9IiNEQURBREEiIHN0cm9rZS1kYXNoYXJyYXk9IjEwLDEwIiBzdHJva2Utd2lkdGg9IjEwIiBtYXNrPSJ1cmwoI2MpIiB4bGluazpocmVmPSIjYSIvPgogICAgICAgIDx0ZXh0IGZpbGw9IiNEM0QzRDMiIGZvbnQtZmFtaWx5PSJIZWx2ZXRpY2FOZXVlLUJvbGQsIEhlbHZldGljYSBOZXVlIiBmb250LXNpemU9IjMwIiBmb250LXdlaWdodD0iYm9sZCI+CiAgICAgICAgICAgIDx0c3BhbiB4PSIyOSIgeT0iMTE5Ij5ObyA8L3RzcGFuPiA8dHNwYW4geD0iMjkiIHk9IjE1MSI+UHJvZHVjdCA8L3RzcGFuPiA8dHNwYW4geD0iMjkiIHk9IjE4MyI+SW1hZ2U8L3RzcGFuPgogICAgICAgIDwvdGV4dD4KICAgICAgICA8dXNlIHN0cm9rZT0iI0RBREFEQSIgc3Ryb2tlLWRhc2hhcnJheT0iMTAsMTAiIHN0cm9rZS13aWR0aD0iMTAiIG1hc2s9InVybCgjZCkiIHRyYW5zZm9ybT0icm90YXRlKDkwIDE1My44NSA0My41KSIgeGxpbms6aHJlZj0iI2IiLz4KICAgIDwvZz4KPC9zdmc+Cg=="
	imageModel, ok := model.FindProductImageModel(pmb.ID, pmb.DB)
	if ok {
		imageURL = imageModel.FormatURL(model.ProductImageSizeFull)
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
	pmb.id(uint32(pmb.ProductModel.ID))
}

// Build returns a built ProductMessage
func (pmb *ProductMessageBuilder) Build() (msg *pb.ProductMessage, err error) {
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
	pmb.brand()
	pmb.categories()
	return pmb.msg, nil
}

type ProductStatsBuilder struct {
	DB        *gorm.DB
	ProductID uint
	prices    []*model.PriceModel
	chartData *pb.ChartMessage
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
	psb.prices = model.FindProductLatestPrices(psb.ProductID, 0, 15, psb.DB)

	// https://github.com/golang/go/wiki/SliceTricks#reversing
	for i := len(psb.prices)/2 - 1; i >= 0; i-- {
		opp := len(psb.prices) - 1 - i
		psb.prices[i], psb.prices[opp] = psb.prices[opp], psb.prices[i]
	}

	labels := make([]string, 0)
	for _, p := range psb.prices {
		labels = append(labels, p.CreatedAt.Format("2006-01-02 15:04"))
	}

	dataSets := make([]*pb.ChartContentMessage, 0)

	priceData := make([]uint32, 0)
	for _, p := range psb.prices {
		priceData = append(priceData, uint32(p.CurrentPrice))
	}

	dataSets = append(dataSets, &pb.ChartContentMessage{
		Label:                "current",
		FillColor:            "rgba(220,220,220,0.2)",
		StrokeColor:          "rgba(220,220,220,1)",
		PointColor:           "rgba(220,220,220,1)",
		PointStrokeColor:     "#fff",
		PointHighlightFill:   "#fff",
		PointHighlightStroke: "rgba(220,220,220,1)",
		Content:              priceData,
	})

	priceData = make([]uint32, 0)
	for _, p := range psb.prices {
		priceData = append(priceData, uint32(p.ListPrice))
	}

	dataSets = append(dataSets, &pb.ChartContentMessage{
		Label:                "listed",
		FillColor:            "rgba(151,187,205,0.2)",
		StrokeColor:          "rgba(151,187,205,0.2)",
		PointColor:           "rgba(151,187,205,1)",
		PointStrokeColor:     "#fff",
		PointHighlightFill:   "#fff",
		PointHighlightStroke: "rgba(151,187,205,1)",
		Content:              priceData,
	})

	psb.chartData = &pb.ChartMessage{
		Labels:  labels,
		Content: dataSets,
	}
}

func (psb *ProductStatsBuilder) Build() (msg *pb.ProductStatsResponse, err error) {
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
		MinPrice:  uint32(psb.min),
		MaxPrice:  uint32(psb.max),
		MeanPrice: psb.mean,
		Chart:     psb.chartData,
	}, nil
}
