package rest

import (
	"bytes"
	"compress/zlib"
	"fmt"
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"github.com/go-redis/redis"
	"github.com/golang/protobuf/proto"
	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
	log "github.com/sirupsen/logrus"
	"io/ioutil"
	"math"
	"strconv"
	"time"
	"trak-gateway/connection"
	"trak-gateway/gateway/grpc"
	"trak-gateway/gateway/response"
	"trak-gateway/takealot/model"

	"net/http"
)

type Handler struct {
	DB          *gorm.DB
	RedisClient *redis.Client
}

func (h *Handler) Quit() {
	connection.CloseMariaDB(h.DB)
	connection.CloseRedisClient(h.RedisClient)
}

func (h *Handler) redisGet(key string) (*[]byte, error) {
	data, err := h.RedisClient.Get(key).Bytes()

	if err != nil {
		return nil, err
	}

	r, err := zlib.NewReader(bytes.NewReader(data))
	if err != nil {
		log.Errorf("failed to decompress message: %v", err)
		return nil, err
	}
	err = r.Close()
	if err != nil {
		log.Errorf("failed to close reader: %v", err)
		return nil, err
	}

	uncompressed, err := ioutil.ReadAll(r)

	return &uncompressed, nil
}

func (h *Handler) redisSet(key string, data *[]byte, duration time.Duration) {
	var b bytes.Buffer
	w := zlib.NewWriter(&b)

	_, err := w.Write(*data)

	if err != nil {
		log.Warnf("failed to compress data: %v", err)
		return
	}

	err = w.Close()
	if err != nil {
		log.Errorf("failed to close writer: %v", err)
		return
	}

	h.RedisClient.Set(key, b.Bytes(), 5*time.Minute)
}

func (h *Handler) GetAllPromotions(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	page := vars["page"]
	pageReq := 1

	if page != "" {
		parseInt, err := strconv.ParseInt(page, 10, 32)
		if err != nil {
			log.Warnf("failed to convert: %s to int32", page)
			sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
			return
		}

		pageReq = int(parseInt)
	}

	pageReq--

	// check redis for cache
	redisKey := fmt.Sprintf("GetAllPromotions-%d", pageReq)
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.GetAllPromotionsResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	promotionMessages := make([]*pb.PromotionMessage, 0)
	promotions := model.FindLatestPromotions(pageReq, 12, h.DB)

	for _, p := range promotions {
		promotionMessages = append(promotionMessages, &pb.PromotionMessage{
			Id:          int64(p.ID),
			Name:        p.DisplayName,
			PromotionId: int64(p.PromotionID),
			Created:     p.CreatedAt.Unix(),
		})
	}

	resp := &pb.GetAllPromotionsResponse{
		Promotions: promotionMessages,
		// todo paging...
		PageResponse: &pb.PageResponse{
			CurrentPageNumber: 0,
			LastPageNumber:    0,
			TotalItems:        0,
			PageSize:          0,
		},
	}

	d, err := proto.Marshal(resp)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, resp)
}

func (h *Handler) GetPromotion(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	page := vars["page"]
	promotionId := vars["id"]
	pageReq := 1
	promotionIdReq := uint(1)

	if page != "" {
		parseInt, err := strconv.ParseInt(page, 10, 32)
		if err != nil {
			log.Warnf("failed to convert: %s to int32", page)
			sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
			return
		}

		pageReq = int(parseInt)
	}

	pageReq--

	if promotionId != "" {
		p, err := strconv.ParseUint(promotionId, 10, 32)
		if err != nil {
			log.Warnf("failed to convert: %s to uint", page)
			sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
			return
		}

		promotionIdReq = uint(p)
	}

	// check redis for cache
	redisKey := fmt.Sprintf("GetPromotion-%d-%d", pageReq, promotionIdReq)
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.PromotionResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	productMessages := make([]*pb.ProductMessage, 0)
	products := model.FindProductsByPromotion(promotionIdReq, pageReq, 12, h.DB)

	for _, pm := range products {
		price := "0"
		priceModel, ok := model.FindProductLatestPrice(pm.ID, h.DB)
		if ok {
			price = fmt.Sprintf("%f", priceModel.CurrentPrice)
		}

		imageURL := "0"
		imageModel, ok := model.FindProductImageModel(pm.ID, h.DB)
		if ok {
			imageURL = imageModel.FormatURL(model.ProductImageSizePreview)
		}
		productMessages = append(productMessages, &pb.ProductMessage{
			Name:       pm.Title,
			ProductUrl: pm.URL,
			ImageUrl:   imageURL,
			Price:      price,
			Id:         int64(pm.ID),
		})
	}

	resp := &pb.PromotionResponse{
		Products: productMessages,
		// todo paging...
		PageResponse: &pb.PageResponse{
			CurrentPageNumber: 0,
			LastPageNumber:    0,
			TotalItems:        0,
			PageSize:          0,
		},
	}

	d, err := proto.Marshal(resp)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, resp)
}

func (h *Handler) DailyDeals(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	page := vars["page"]
	pageReq := 1

	if page != "" {
		parseInt, err := strconv.ParseInt(page, 10, 32)
		if err != nil {
			log.Warnf("failed to convert: %s to int32", page)
			sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
			return
		}

		pageReq = int(parseInt)
	}

	pageReq--

	// check redis for cache
	redisKey := fmt.Sprintf("DailyDeals-%d", pageReq)
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.PromotionResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	promotionModel, ok := model.FindLatestDailyDealPromotion(h.DB)

	if !ok {
		log.Warn("no Daily Deals available")
		sendError(w, &response.Error{Message: "no Daily Deals available", Type: response.BadRequest})
		return
	}

	productMessages := make([]*pb.ProductMessage, 0)
	products := model.FindProductsByPromotion(promotionModel.ID, pageReq, 12, h.DB)

	for _, pm := range products {
		price := "0"
		priceModel, ok := model.FindProductLatestPrice(pm.ID, h.DB)
		if ok {
			price = fmt.Sprintf("%f", priceModel.CurrentPrice)
		}

		imageURL := "0"
		imageModel, ok := model.FindProductImageModel(pm.ID, h.DB)
		if ok {
			imageURL = imageModel.FormatURL(model.ProductImageSizePreview)
		}
		productMessages = append(productMessages, &pb.ProductMessage{
			Name:       pm.Title,
			ProductUrl: pm.URL,
			ImageUrl:   imageURL,
			Price:      price,
			Id:         int64(pm.ID),
		})
	}

	resp := &pb.PromotionResponse{
		Products: productMessages,
		// todo paging...
		PageResponse: &pb.PageResponse{
			CurrentPageNumber: 0,
			LastPageNumber:    0,
			TotalItems:        0,
			PageSize:          0,
		},
	}

	d, err := proto.Marshal(resp)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, resp)
}

func (h *Handler) CategorySearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	// check redis for cache
	redisKey := fmt.Sprintf("CategorySearch-%s", s)
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.SearchResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	resp, grpcErr := grpc.CategorySearch(&pb.SearchRequest{Search: s})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	var results []*pb.SearchResult
	for _, r := range resp.Results {
		id, e := strconv.ParseUint(r.Id, 10, 32)
		if e != nil {
			log.Warnf("failed to convert %s to int64: %v", r.Id, e)
			continue
		}

		categoryModel, ok := model.FindCategoryModel(uint(id), h.DB)

		if !ok {
			sendError(w, &response.Error{
				Message: fmt.Sprintf("No category for ID: %d", id),
				Type:    response.ServerError,
			})
			return
		}

		results = append(results, &pb.SearchResult{
			Id:    fmt.Sprintf("%d", categoryModel.ID),
			Name:  categoryModel.Name,
			Score: 0,
		})
	}

	searchResponse := &pb.SearchResponse{Results: results}
	d, err := proto.Marshal(searchResponse)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, searchResponse)
}

func (h *Handler) BrandSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	// check redis for cache
	redisKey := fmt.Sprintf("BrandSearch-%s", s)
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.SearchResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	resp, grpcErr := grpc.BrandSearch(&pb.SearchRequest{Search: s})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	var results []*pb.SearchResult
	for _, r := range resp.Results {
		id, e := strconv.ParseUint(r.Id, 10, 32)
		if e != nil {
			log.Warnf("failed to convert %s to int64: %v", r.Id, e)
			continue
		}

		brandModel, ok := model.FindBrandModel(uint(id), h.DB)

		if !ok {
			sendError(w, &response.Error{
				Message: fmt.Sprintf("No brand for ID: %d", id),
				Type:    response.ServerError,
			})
			return
		}

		results = append(results, &pb.SearchResult{
			Id:    fmt.Sprintf("%d", brandModel.ID),
			Name:  brandModel.Name,
			Score: 0,
		})
	}

	searchResponse := &pb.SearchResponse{Results: results}
	d, err := proto.Marshal(searchResponse)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, searchResponse)
}

func (h *Handler) ProductSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	// check redis for cache
	redisKey := fmt.Sprintf("ProductSearch-%s", s)
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.SearchResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	resp, grpcErr := grpc.ProductSearch(&pb.SearchRequest{Search: s})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	var results []*pb.SearchResult
	for _, r := range resp.Results {
		id, e := strconv.ParseUint(r.Id, 10, 32)
		if e != nil {
			log.Warnf("failed to convert %s to int64: %v", r.Id, e)
			continue
		}

		productModel, ok := model.FindProductModel(uint(id), h.DB)

		if !ok {
			sendError(w, &response.Error{
				Message: fmt.Sprintf("No product for ID: %d", id),
				Type:    response.ServerError,
			})
			return
		}

		results = append(results, &pb.SearchResult{
			Id:    fmt.Sprintf("%d", productModel.ID),
			Name:  productModel.Title,
			Score: 0,
		})
	}

	searchResponse := &pb.SearchResponse{Results: results}
	d, err := proto.Marshal(searchResponse)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, searchResponse)
}

// todo add pagination in request
func (h *Handler) GetBrandById(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	brandId, e := strconv.ParseUint(vars["brandId"], 10, 32)

	if e != nil {
		log.Warnf("failed to convert: %s to uint", vars["brandId"])
		sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
		return
	}

	// check redis for cache
	redisKey := fmt.Sprintf("GetBrandById-%d", brandId)
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.BrandResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	brandModel, ok := model.FindBrandModel(uint(brandId), h.DB)

	if !ok {
		sendError(w, &response.Error{
			Message: fmt.Sprintf("No brand for ID: %d", uint(brandId)),
			Type:    response.ServerError,
		})
		return
	}

	productModels := model.FindProductsByBrand(uint(brandId), 0, 12, h.DB)
	products := make([]*pb.ProductMessage, 0)

	// todo do these in their own goroutine
	for _, pm := range productModels {
		price := "0"
		priceModel, ok := model.FindProductLatestPrice(pm.ID, h.DB)
		if ok {
			price = fmt.Sprintf("%f", priceModel.CurrentPrice)
		}

		imageURL := "0"
		imageModel, ok := model.FindProductImageModel(pm.ID, h.DB)
		if ok {
			imageURL = imageModel.FormatURL(model.ProductImageSizePreview)
		}

		msg := &pb.ProductMessage{
			Name:       pm.Title,
			ProductUrl: pm.URL,
			Price:      price,
			ImageUrl:   imageURL,
			Id:         int64(pm.ID),
			Brand: &pb.BrandMessage{
				Id:   int64(brandModel.ID),
				Name: brandModel.Name,
			},
			// todo
			Categories: nil,
		}

		products = append(products, msg)
	}

	resp := &pb.BrandResponse{
		BrandId:  int64(brandId),
		Name:     brandModel.Name,
		Products: products,
	}

	d, err := proto.Marshal(resp)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, resp)
}

// todo add pagination in request
func (h *Handler) GetCategoryId(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	categoryId, e := strconv.ParseUint(vars["categoryId"], 10, 64)

	if e != nil {
		log.Warnf("failed to convert: %s to uint", vars["categoryId"])
		sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
		return
	}

	// check redis for cache
	redisKey := fmt.Sprintf("GetCategoryId-%d", categoryId)
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.CategoryResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	categoryModel, ok := model.FindCategoryModel(uint(categoryId), h.DB)

	if !ok {
		sendError(w, &response.Error{
			Message: fmt.Sprintf("No category for ID: %d", uint(categoryId)),
			Type:    response.ServerError,
		})
		return
	}

	productModels := model.FindProductsByCategory(categoryModel.ID, 0, 12, h.DB)
	products := make([]*pb.ProductMessage, 0)

	// todo do these in their own goroutine
	for _, pm := range productModels {
		price := "0"
		priceModel, ok := model.FindProductLatestPrice(pm.ID, h.DB)
		if ok {
			price = fmt.Sprintf("%f", priceModel.CurrentPrice)
		}

		imageURL := "0"
		imageModel, ok := model.FindProductImageModel(pm.ID, h.DB)
		if ok {
			imageURL = imageModel.FormatURL(model.ProductImageSizePreview)
		}

		msg := &pb.ProductMessage{
			Name:       pm.Title,
			ProductUrl: pm.URL,
			Price:      price,
			ImageUrl:   imageURL,
			Id:         int64(pm.ID),
			// todo populate brand and category
			Brand:      nil,
			Categories: nil,
		}

		products = append(products, msg)
	}
	resp := &pb.CategoryResponse{
		CategoryId: int64(categoryModel.ID),
		Name:       categoryModel.Name,
		Products:   products,
	}

	d, err := proto.Marshal(resp)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, resp)
}

func (h *Handler) GetProductById(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	productId, e := strconv.ParseUint(vars["productId"], 10, 32)

	if e != nil {
		log.Warnf("failed to convert: %s to uint", vars["productId"])
		sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
		return
	}

	// check redis for cache
	redisKey := fmt.Sprintf("GetProductById-%d", productId)
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.ProductResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	productModel, ok := model.FindProductModel(uint(productId), h.DB)

	if !ok {
		sendError(w, &response.Error{
			Message: fmt.Sprintf("No category for ID: %d", uint(productId)),
			Type:    response.ServerError,
		})
		return
	}

	prices := model.FindProductLatestPrices(productModel.ID, 0, 30, h.DB)

	price := ""
	if len(prices) > 0 {
		price = fmt.Sprintf("%f", prices[0].CurrentPrice)
	}

	imageURL := "0"
	imageModel, ok := model.FindProductImageModel(productModel.ID, h.DB)
	if ok {
		imageURL = imageModel.FormatURL(model.ProductImageSizePreview)
	}

	brandModel, ok := model.FindProductBrand(productModel.ID, h.DB)
	if !ok {
		log.Warnf("No brand for productID: %d", productModel.ID)
		brandModel = &model.BrandModel{
			Model: gorm.Model{ID: 0},
			Name:  "UNKNOWN",
		}
	}

	categories := make([]*pb.CategoryMessage, 0)
	categoryModels := model.FindProductCategories(productModel.ID, h.DB)

	for _, cm := range categoryModels {
		categories = append(categories, &pb.CategoryMessage{
			Id:   int64(cm.ID),
			Name: cm.Name,
		})
	}

	productMessage := &pb.ProductMessage{
		Name:       productModel.Title,
		ProductUrl: productModel.URL,
		Price:      price,
		ImageUrl:   imageURL,
		Id:         int64(productModel.ID),
		Brand: &pb.BrandMessage{
			Id:   int64(brandModel.ID),
			Name: brandModel.Name,
		},
		Categories: categories,
	}

	labels := make([]string, 0)
	for _, p := range prices {
		labels = append(labels, p.CreatedAt.String())
	}

	dataSets := make([]*pb.ChartDataSetMessage, 0)

	priceData := make([]int64, 0)
	for _, p := range prices {
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
	for _, p := range prices {
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

	chartData := &pb.ChartDataMessage{
		Labels:   labels,
		DataSets: dataSets,
	}

	min := math.MaxFloat64
	max := float64(0)
	total := float64(0)
	isFirst := true
	for _, p := range prices {
		if isFirst {
			isFirst = false
			min = p.CurrentPrice
			max = p.CurrentPrice
		}
		total += p.CurrentPrice
		if p.CurrentPrice < min {
			min = p.CurrentPrice
		}

		if p.CurrentPrice > max {
			max = p.CurrentPrice
		}
	}

	mean := total
	if len(prices) > 0 {
		mean = math.Round(total / float64(len(prices)))
	}

	statsResponse := &pb.ProductStatsResponse{
		MinPrice:  int64(min),
		MaxPrice:  int64(max),
		MeanPrice: mean,
		ChartData: chartData,
	}

	resp := &pb.ProductResponse{
		Product: productMessage,
		Stats:   statsResponse,
	}

	d, err := proto.Marshal(resp)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, resp)
}

// todo add pagination in request
func (h *Handler) LatestHandler(w http.ResponseWriter, req *http.Request) {
	// check redis for cache
	redisKey := "Latest"
	data, err := h.redisGet(redisKey)
	if err == nil {
		// we have cached response
		resp := &pb.LatestResponse{}
		err := proto.Unmarshal(*data, resp)
		if err != nil {
			log.Warnf("failed to unmarshal bytes to proto")
		} else {
			sendOK(w, resp)
			return
		}
	}

	products := model.FindLatestProducts(0, 12, h.DB)
	productMessages := make([]*pb.ProductMessage, 0)

	for _, p := range products {
		imageModel, ok := model.FindProductImageModel(p.ID, h.DB)
		imageURL := ""
		if ok {
			imageURL = imageModel.FormatURL(model.ProductImageSizePreview)
		}
		productMessages = append(productMessages, &pb.ProductMessage{
			Name:       p.Title,
			ProductUrl: p.URL,
			ImageUrl:   imageURL,
			Id:         int64(p.ID),
		})
	}

	resp := &pb.LatestResponse{
		Products: productMessages,
		Page:     nil,
	}

	d, err := proto.Marshal(resp)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}

	if len(d) > 0 {
		h.redisSet(redisKey, &d, 5*time.Minute)
	}

	sendOK(w, resp)
}
