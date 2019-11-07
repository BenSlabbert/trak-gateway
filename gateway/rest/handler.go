package rest

import (
	"fmt"
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"github.com/go-redis/redis"
	"github.com/golang/protobuf/proto"
	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
	log "github.com/sirupsen/logrus"
	"strconv"
	"time"
	"trak-gateway/connection"
	"trak-gateway/gateway/builder"
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

func (h *Handler) redisGet(key string, msg proto.Message) error {
	data, err := h.RedisClient.Get(key).Bytes()
	if err != nil {
		return err
	}

	// we have cached response
	err = proto.Unmarshal(data, msg)
	if err != nil {
		log.Warnf("failed to unmarshal bytes to proto")
		return err
	}
	return err
}

func (h *Handler) redisSet(key string, msg proto.Message) {
	d, err := proto.Marshal(msg)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}
	h.RedisClient.Set(key, d, 10*time.Minute)
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
	resp := &pb.GetAllPromotionsResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
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

	resp = &pb.GetAllPromotionsResponse{
		Promotions: promotionMessages,
		// todo paging...
		PageResponse: &pb.PageResponse{
			CurrentPageNumber: 0,
			LastPageNumber:    0,
			TotalItems:        0,
			PageSize:          0,
		},
	}

	h.redisSet(redisKey, resp)
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
	resp := &pb.PromotionResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	productMessages := make([]*pb.ProductMessage, 0)
	products := model.FindProductsByPromotion(promotionIdReq, pageReq, 12, h.DB)

	// todo run in own goroutines
	for _, pm := range products {
		pmb := builder.ProductMessageBuilder{
			DB:           h.DB,
			ID:           pm.ID,
			ProductModel: pm,
		}

		msg, _ := pmb.Build()
		if msg != nil {
			productMessages = append(productMessages, msg)
		}
	}

	resp = &pb.PromotionResponse{
		Products: productMessages,
		// todo paging...
		PageResponse: &pb.PageResponse{
			CurrentPageNumber: 0,
			LastPageNumber:    0,
			TotalItems:        0,
			PageSize:          0,
		},
	}

	h.redisSet(redisKey, resp)
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
	resp := &pb.PromotionResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	promotionModel, ok := model.FindLatestDailyDealPromotion(h.DB)

	if !ok {
		log.Warn("no Daily Deals available")
		sendError(w, &response.Error{Message: "no Daily Deals available", Type: response.BadRequest})
		return
	}

	productMessages := make([]*pb.ProductMessage, 0)
	products := model.FindProductsByPromotion(promotionModel.ID, pageReq, 12, h.DB)

	// todo run in own goroutines
	for _, pm := range products {
		pmb := builder.ProductMessageBuilder{
			DB:           h.DB,
			ID:           pm.ID,
			ProductModel: pm,
		}

		msg, _ := pmb.Build()
		if msg != nil {
			productMessages = append(productMessages, msg)
		}
	}

	resp = &pb.PromotionResponse{
		Products: productMessages,
		// todo paging...
		PageResponse: &pb.PageResponse{
			CurrentPageNumber: 0,
			LastPageNumber:    0,
			TotalItems:        0,
			PageSize:          0,
		},
	}

	h.redisSet(redisKey, resp)
	sendOK(w, resp)
}

func (h *Handler) CategorySearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	// check redis for cache
	redisKey := fmt.Sprintf("CategorySearch-%s", s)
	resp := &pb.SearchResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
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

	resp = &pb.SearchResponse{Results: results}
	h.redisSet(redisKey, resp)
	sendOK(w, resp)
}

func (h *Handler) BrandSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	// check redis for cache
	redisKey := fmt.Sprintf("BrandSearch-%s", s)
	resp := &pb.SearchResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
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

	resp = &pb.SearchResponse{Results: results}
	h.redisSet(redisKey, resp)
	sendOK(w, resp)
}

func (h *Handler) ProductSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	// check redis for cache
	redisKey := fmt.Sprintf("ProductSearch-%s", s)
	resp := &pb.SearchResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
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

	resp = &pb.SearchResponse{Results: results}
	h.redisSet(redisKey, resp)
	sendOK(w, resp)
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
	resp := &pb.BrandResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
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
		pmb := builder.ProductMessageBuilder{
			DB:           h.DB,
			ID:           pm.ID,
			ProductModel: pm,
		}

		msg, _ := pmb.Build()
		if msg != nil {
			products = append(products, msg)
		}
	}

	resp = &pb.BrandResponse{
		BrandId:  int64(brandId),
		Name:     brandModel.Name,
		Products: products,
	}
	h.redisSet(redisKey, resp)
	sendOK(w, resp)
}

// todo add pagination in request
func (h *Handler) GetCategoryById(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	categoryId, e := strconv.ParseUint(vars["categoryId"], 10, 64)

	if e != nil {
		log.Warnf("failed to convert: %s to uint", vars["categoryId"])
		sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
		return
	}

	// check redis for cache
	redisKey := fmt.Sprintf("GetCategoryById-%d", categoryId)
	resp := &pb.CategoryResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
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
		pmb := builder.ProductMessageBuilder{
			DB:           h.DB,
			ID:           pm.ID,
			ProductModel: pm,
		}

		msg, _ := pmb.Build()
		if msg != nil {
			products = append(products, msg)
		}
	}
	resp = &pb.CategoryResponse{
		CategoryId: int64(categoryModel.ID),
		Name:       categoryModel.Name,
		Products:   products,
	}
	h.redisSet(redisKey, resp)
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
	resp := &pb.ProductResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	pmb := builder.ProductMessageBuilder{
		DB: h.DB,
		ID: uint(productId),
	}

	productMessage, e := pmb.Build()
	if e != nil {
		sendError(w, &response.Error{
			Message: fmt.Sprintf("No product for ID: %d", uint(productId)),
			Type:    response.ServerError,
		})
		return
	}

	statsBuilder := builder.ProductStatsBuilder{
		DB:        h.DB,
		ProductID: uint(productId),
	}

	statsResponse, _ := statsBuilder.Build()

	resp = &pb.ProductResponse{
		Product: productMessage,
		Stats:   statsResponse,
	}
	h.redisSet(redisKey, resp)
	sendOK(w, resp)
}

// todo add pagination in request
func (h *Handler) LatestHandler(w http.ResponseWriter, req *http.Request) {
	// check redis for cache
	redisKey := "Latest"
	resp := &pb.LatestResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	products := model.FindLatestProducts(0, 12, h.DB)
	productMessages := make([]*pb.ProductMessage, 0)

	// todo run in own goroutines
	for _, p := range products {
		pmb := builder.ProductMessageBuilder{
			DB:           h.DB,
			ID:           p.ID,
			ProductModel: p,
		}
		msg, _ := pmb.Build()
		if msg != nil {
			productMessages = append(productMessages, msg)
		}
	}

	resp = &pb.LatestResponse{
		Products: productMessages,
		Page:     nil,
	}
	h.redisSet(redisKey, resp)
	sendOK(w, resp)
}
