package rest

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"github.com/gorilla/mux"
	log "github.com/sirupsen/logrus"
	"strconv"
	"trak-gateway/gateway/grpc"
	"trak-gateway/gateway/response"

	"net/http"
)

func GetAllPromotions(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	page := vars["page"]
	pageReq := int32(1)

	if page != "" {
		parseInt, err := strconv.ParseInt(page, 10, 32)
		if err != nil {
			log.Warnf("Failed to convert: %s to int32", page)
			sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
			return
		}

		pageReq = int32(parseInt)
	}

	resp, grpcErr := grpc.GetAllPromotions(&pb.GetAllPromotionsRequest{
		PageRequest: &pb.PageRequestMessage{
			Page:    pageReq - 1,
			PageLen: 12,
		},
	})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}

func GetPromotion(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	page := vars["page"]
	promotionId := vars["id"]
	pageReq := int32(1)
	promotionIdReq := int64(1)

	if page != "" {
		parseInt, err := strconv.ParseInt(page, 10, 32)
		if err != nil {
			log.Warnf("Failed to convert: %s to int32", page)
			sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
			return
		}

		pageReq = int32(parseInt)
	}

	if promotionId != "" {
		p, err := strconv.ParseInt(promotionId, 10, 64)
		if err != nil {
			log.Warnf("Failed to convert: %s to int32", page)
			sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
			return
		}

		promotionIdReq = p
	}

	resp, grpcErr := grpc.GetPromotion(&pb.PromotionRequest{
		Deal: &pb.PromotionRequest_PromotionId{
			PromotionId: promotionIdReq,
		},
		PageRequest: &pb.PageRequestMessage{
			Page:    pageReq - 1,
			PageLen: 12,
		},
	})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}

func DailyDeals(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	page := vars["page"]
	pageReq := int32(1)

	if page != "" {
		parseInt, err := strconv.ParseInt(page, 10, 32)
		if err != nil {
			log.Warnf("Failed to convert: %s to int32", page)
			sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
			return
		}

		pageReq = int32(parseInt)
	}

	resp, grpcErr := grpc.GetPromotion(&pb.PromotionRequest{
		Deal: &pb.PromotionRequest_DailyDeal{
			DailyDeal: true,
		},
		PageRequest: &pb.PageRequestMessage{
			Page:    pageReq - 1,
			PageLen: 12,
		},
	})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}

func CategorySearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	resp, grpcErr := grpc.CategorySearch(&pb.SearchRequest{Search: s})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}

func BrandSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	resp, grpcErr := grpc.BrandSearch(&pb.SearchRequest{Search: s})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}

func ProductSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	resp, grpcErr := grpc.ProductSearch(&pb.SearchRequest{Search: s})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}

func GetBrandById(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	brandId, e := strconv.ParseInt(vars["brandId"], 10, 64)

	if e != nil {
		log.Warnf("Failed to convert: %s to int32", vars["brandId"])
		sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
		return
	}

	resp, grpcErr := grpc.GetBrand(&pb.BrandRequest{BrandId: brandId})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}

func GetCategoryId(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	categoryId, e := strconv.ParseInt(vars["categoryId"], 10, 64)

	if e != nil {
		log.Warnf("Failed to convert: %s to int32", vars["categoryId"])
		sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
		return
	}

	resp, grpcErr := grpc.GetCategory(&pb.CategoryRequest{CategoryId: categoryId})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}

func GetProductById(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	productId, e := strconv.ParseInt(vars["productId"], 10, 64)

	if e != nil {
		log.Warnf("Failed to convert: %s to int32", vars["productId"])
		sendError(w, &response.Error{Message: "Failed to parse number", Type: response.BadRequest})
		return
	}

	resp, grpcErr := grpc.GetProduct(&pb.ProductRequest{ProductId: productId})

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}

func LatestHandler(w http.ResponseWriter, req *http.Request) {
	resp, grpcErr := grpc.GetLatestItems()

	if grpcErr != nil {
		sendError(w, grpcErr)
		return
	}

	sendOK(w, resp)
}
