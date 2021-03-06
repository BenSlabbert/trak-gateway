package rest

import (
	"errors"
	"fmt"
	gatewayPB "github.com/BenSlabbert/trak-gRPC/gen/go/proto/gateway"
	searchPB "github.com/BenSlabbert/trak-gRPC/gen/go/proto/search"
	"github.com/go-redis/redis"
	"github.com/go-resty/resty/v2"
	"github.com/golang/protobuf/proto"
	"github.com/gorilla/mux"
	"github.com/jinzhu/gorm"
	log "github.com/sirupsen/logrus"
	"io/ioutil"
	"net/url"
	"strconv"
	"strings"
	"time"
	"trak-gateway/connection"
	"trak-gateway/gateway/builder"
	"trak-gateway/gateway/grpc"
	"trak-gateway/gateway/response"
	"trak-gateway/takealot/env"
	"trak-gateway/takealot/model"
	"trak-gateway/takealot/queue"

	"net/http"
)

type Handler struct {
	DB          *gorm.DB
	RedisClient *redis.Client
	TrakEnv     env.TrakEnv
}

func (h *Handler) Quit() {
	connection.CloseMariaDB(h.DB)
	connection.CloseRedisClient(h.RedisClient)
}

func (h *Handler) redisGet(key string, msg proto.Message) error {
	if h.TrakEnv.Redis.DisableCaching {
		return errors.New("caching disabled")
	}

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
	if h.TrakEnv.Redis.DisableCaching {
		return
	}

	d, err := proto.Marshal(msg)

	if err != nil {
		log.Warnf("failed to marshall proto to bytes: %v", err)
	}
	h.RedisClient.Set(key, d, 10*time.Minute)
}

func (h *Handler) AddProduct(w http.ResponseWriter, req *http.Request) {
	bytes, e := ioutil.ReadAll(req.Body)
	if e != nil {
		log.Warnf("failed to read request body: %v", e)
		sendError(w, &response.Error{Message: "Invalid request", Type: response.BadRequest})
		return
	}

	addProductReq := &gatewayPB.AddProductRequest{}
	e = proto.Unmarshal(bytes, addProductReq)

	if e != nil {
		log.Warnf("failed to get URL from message: %v", e)
		sendError(w, &response.Error{Message: "No URL provided", Type: response.BadRequest})
		return
	}

	plID, e := h.plIDFromURL(addProductReq.Url)
	if e != nil {
		log.Warnf("failed to verify url: %s: %v", addProductReq.Url, e)
		sendError(w, &response.Error{Message: fmt.Sprintf("Invalid URL provided: %s", addProductReq.Url), Type: response.BadRequest})
		return
	}

	// push plid to create product work queue
	producer := queue.CreateNSQProducer()
	defer producer.Stop()

	e = producer.Publish(queue.NewProductQueue, queue.SendUintMessage(plID))
	if e != nil {
		log.Warnf("failed to publish to nsq: %v", e)
		sendError(w, &response.Error{Message: "Server error", Type: response.ServerError})
		return
	}

	sendOK(w, &gatewayPB.Empty{})
}

func (h *Handler) plIDFromURL(u string) (uint, error) {
	uri, e := url.ParseRequestURI(u)
	if e != nil {
		log.Warnf("invalid url provided: %v", e)
		return 0, e
	}

	if uri.Host != "www.takealot.com" {
		log.Warnf("invalid url provided, not a takealot.com host: %s", uri.Host)
		return 0, errors.New("url host is not www.takealot.com")
	}

	if !strings.Contains(uri.String(), "PLID") {
		log.Warnf("invalid url provided, no PLID specified: %s", uri.String())
		return 0, errors.New("no PLID specified")
	}

	// check if we can go to that url
	client := resty.New().
		SetRedirectPolicy(resty.FlexibleRedirectPolicy(5)).
		SetTimeout(10 * time.Second)
	resp, e := client.R().Get(uri.String())
	if e != nil || !resp.IsSuccess() {
		log.Warnf("failed to go to url: %s: %v", uri.String(), e)
		return 0, e
	}

	pathSegments := strings.Split(uri.Path, "/")
	if len(pathSegments) <= 2 {
		log.Warnf("not enough path segments in url: %s", uri.String())
		return 0, errors.New("invalid URL provided")
	}

	plIDString := pathSegments[len(pathSegments)-1]
	if !strings.HasPrefix(plIDString, "PLID") {
		log.Warnf("invalid URL provided: %v", e)
		return 0, e
	}

	parseUint, e := strconv.ParseUint(plIDString[4:], 10, 32)
	if e != nil {
		log.Warnf("invalid url provided: %v", e)
		return 0, e
	}

	return uint(parseUint), nil
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
	resp := &gatewayPB.GetAllPromotionsResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	promotionMessages := make([]*gatewayPB.PromotionMessage, 0)
	promotions, queryPage := model.FindLatestPromotions(pageReq, 12, h.DB)

	for _, p := range promotions {
		promotionMessages = append(promotionMessages, &gatewayPB.PromotionMessage{
			Id:          uint32(p.ID),
			Name:        p.DisplayName,
			PromotionId: uint32(p.PromotionID),
			Start:       uint32(p.StartDate.Unix()),
			End:         uint32(p.EndDate.Unix()),
		})
	}

	resp = &gatewayPB.GetAllPromotionsResponse{
		Promotions: promotionMessages,
		PageResponse: &gatewayPB.PageResponse{
			// re-increment for the ui
			CurrentPageNumber: uint32(queryPage.CurrentPage) + 1,
			LastPageNumber:    uint32(queryPage.LastPage),
			TotalItems:        uint32(queryPage.TotalItems),
			PageSize:          uint32(queryPage.PageSize),
			IsFirstPage:       queryPage.IsFirstPage,
			IsLastPage:        queryPage.IsLastPage,
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
	resp := &gatewayPB.PromotionResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	promotionModel, ok := model.FindPromotion(promotionIdReq, h.DB)
	if !ok {
		log.Warnf("failed to find promotion with ID: %d", promotionIdReq)
		sendError(w, &response.Error{Message: "Failed to find promotion", Type: response.BadRequest})
		return
	}

	productModels, queryPage := model.FindProductsByPromotion(promotionIdReq, pageReq, 12, h.DB)
	productMessages := h.getProductMessages(productModels)

	resp = &gatewayPB.PromotionResponse{
		Products: productMessages,
		PageResponse: &gatewayPB.PageResponse{
			// re-increment for the ui
			CurrentPageNumber: uint32(queryPage.CurrentPage) + 1,
			LastPageNumber:    uint32(queryPage.LastPage),
			TotalItems:        uint32(queryPage.TotalItems),
			PageSize:          uint32(queryPage.PageSize),
			IsFirstPage:       queryPage.IsFirstPage,
			IsLastPage:        queryPage.IsLastPage,
		},
		Promotion: &gatewayPB.PromotionMessage{
			Id:          uint32(promotionModel.ID),
			Name:        promotionModel.DisplayName,
			PromotionId: uint32(promotionModel.PromotionID),
			Start:       uint32(promotionModel.StartDate.Unix()),
			End:         uint32(promotionModel.EndDate.Unix()),
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
	resp := &gatewayPB.PromotionResponse{}
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

	productModels, queryPage := model.FindProductsByPromotion(promotionModel.ID, pageReq, 12, h.DB)
	productMessages := h.getProductMessages(productModels)

	resp = &gatewayPB.PromotionResponse{
		Products: productMessages,
		PageResponse: &gatewayPB.PageResponse{
			// re-increment for the ui
			CurrentPageNumber: uint32(queryPage.CurrentPage) + 1,
			LastPageNumber:    uint32(queryPage.LastPage),
			TotalItems:        uint32(queryPage.TotalItems),
			PageSize:          uint32(queryPage.PageSize),
			IsFirstPage:       queryPage.IsFirstPage,
			IsLastPage:        queryPage.IsLastPage,
		},
		Promotion: &gatewayPB.PromotionMessage{
			Id:          uint32(promotionModel.ID),
			Name:        promotionModel.DisplayName,
			PromotionId: uint32(promotionModel.PromotionID),
			Start:       uint32(promotionModel.StartDate.Unix()),
			End:         uint32(promotionModel.EndDate.Unix()),
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
	resp := &searchPB.CategorySearchResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	// only for ProductSearch
	if strings.HasPrefix(s, "PLID") {
		sendOK(w, &searchPB.CategorySearchRequest{})
		return
	}

	resp, grpcErr := grpc.CategorySearch(&searchPB.CategorySearchRequest{Search: s})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	results := make([]*searchPB.SearchResult, 0)
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

		results = append(results, &searchPB.SearchResult{
			Id:   fmt.Sprintf("%d", categoryModel.ID),
			Text: categoryModel.Name,
		})
	}

	resp = &searchPB.CategorySearchResponse{Results: results}
	h.redisSet(redisKey, resp)
	sendOK(w, resp)
}

func (h *Handler) BrandSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	// check redis for cache
	redisKey := fmt.Sprintf("BrandSearch-%s", s)
	resp := &searchPB.BrandSearchResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	// only for ProductSearch
	if strings.HasPrefix(s, "PLID") {
		sendOK(w, &searchPB.BrandSearchResponse{})
		return
	}

	resp, grpcErr := grpc.BrandSearch(&searchPB.BrandSearchRequest{Search: s})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	results := make([]*searchPB.SearchResult, 0)
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

		results = append(results, &searchPB.SearchResult{
			Id:    fmt.Sprintf("%d", brandModel.ID),
			Text:  brandModel.Name,
			Score: 0,
		})
	}

	resp = &searchPB.BrandSearchResponse{Results: results}
	h.redisSet(redisKey, resp)
	sendOK(w, resp)
}

func (h *Handler) ProductSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	// check redis for cache
	redisKey := fmt.Sprintf("ProductSearch-%s", s)
	resp := &searchPB.ProductSearchResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	if strings.HasPrefix(s, "PLID") {
		// search for product with this plID
		plID, err := strconv.ParseUint(strings.TrimPrefix(s, "PLID"), 10, 32)
		if err != nil {
			log.Warnf("client query: %s does not contain valid plID", s)
			sendError(w, &response.Error{Message: "Invalid PLID provided", Type: response.BadRequest})
			return
		}

		productModelExists, ok := model.ProductModelExistsByPLID(uint(plID), h.DB)
		if !ok {
			log.Warnf("no product found for plID: %d", plID)
			// push plid to create product work queue
			producer := queue.CreateNSQProducer()
			defer producer.Stop()

			e := producer.Publish(queue.NewProductQueue, queue.SendUintMessage(uint(plID)))
			if e != nil {
				log.Warnf("failed to publish to nsq: %v", e)
				sendError(w, &response.Error{Message: "Server error", Type: response.ServerError})
				return
			}

			sendError(w, &response.Error{Message: fmt.Sprintf("No product found for PLID: %s we have added this product now, check back later", s), Type: response.BadRequest})
			return
		}

		productModel, _ := model.FindProductModel(productModelExists.ID, h.DB)
		results := make([]*searchPB.SearchResult, 0)
		results = append(results, &searchPB.SearchResult{
			Id:    fmt.Sprintf("%d", productModel.ID),
			Text:  productModel.Title,
			Score: 0,
		})

		resp = &searchPB.ProductSearchResponse{Results: results}
		h.redisSet(redisKey, resp)
		sendOK(w, resp)
		return
	}

	resp, grpcErr := grpc.ProductSearch(&searchPB.ProductSearchRequest{Search: s})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	results := make([]*searchPB.SearchResult, 0)
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

		results = append(results, &searchPB.SearchResult{
			Id:    fmt.Sprintf("%d", productModel.ID),
			Text:  productModel.Title,
			Score: 0,
		})
	}

	resp = &searchPB.ProductSearchResponse{Results: results}
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
	resp := &gatewayPB.BrandResponse{}
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
	productMessages := h.getProductMessages(productModels)

	resp = &gatewayPB.BrandResponse{
		BrandId:  uint32(brandId),
		Name:     brandModel.Name,
		Products: productMessages,
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
	resp := &gatewayPB.CategoryResponse{}
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
	productMessages := h.getProductMessages(productModels)

	resp = &gatewayPB.CategoryResponse{
		CategoryId: uint32(categoryModel.ID),
		Name:       categoryModel.Name,
		Products:   productMessages,
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
	resp := &gatewayPB.ProductResponse{}
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

	resp = &gatewayPB.ProductResponse{
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
	resp := &gatewayPB.LatestResponse{}
	err := h.redisGet(redisKey, resp)
	if err == nil {
		sendOK(w, resp)
		return
	}

	productModels, _ := model.FindLatestProducts(0, 12, h.DB)
	productMessages := h.getProductMessages(productModels)

	resp = &gatewayPB.LatestResponse{
		Products: productMessages,
		Page:     nil,
	}
	h.redisSet(redisKey, resp)
	sendOK(w, resp)
}

func (h *Handler) getProductMessages(productModels []*model.ProductModel) []*gatewayPB.ProductMessage {
	productMessages := make([]*gatewayPB.ProductMessage, 0)
	productMessageChan := make(chan *gatewayPB.ProductMessage)
	defer close(productMessageChan)

	for _, pm := range productModels {
		pm := pm
		go func(pm *model.ProductModel) {
			pmb := builder.ProductMessageBuilder{
				DB:           h.DB,
				ID:           pm.ID,
				ProductModel: pm,
			}

			msg, _ := pmb.Build()
			productMessageChan <- msg
		}(pm)
	}

	for range productModels {
		message := <-productMessageChan
		if message != nil {
			productMessages = append(productMessages, message)
		}
	}

	return productMessages
}
