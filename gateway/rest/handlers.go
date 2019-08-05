package rest

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"github.com/golang/protobuf/jsonpb"
	"github.com/golang/protobuf/proto"
	"github.com/gorilla/mux"
	log "github.com/sirupsen/logrus"
	"strconv"
	"trak-gateway/gateway"

	"net/http"
)

func DailyDeals(w http.ResponseWriter, req *http.Request) {
	resp, ok := gateway.GetPromotion(&pb.PromotionRequest{
		Deal: &pb.PromotionRequest_DailyDeal{
			DailyDeal: true,
		},
		PageRequest: &pb.PageRequestMessage{
			Page:    0,
			PageLen: 12,
		},
	})

	if !ok {
		// todo send err
		return
	}

	sendJson(w, resp)
}

func CategorySearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	resp, ok := gateway.CategorySearch(&pb.SearchRequest{Search: s})

	if !ok {
		// todo send err
		return
	}

	sendJson(w, resp)
}

func BrandSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	resp, ok := gateway.BrandSearch(&pb.SearchRequest{Search: s})

	if !ok {
		// todo send err
		return
	}

	sendJson(w, resp)
}

func ProductSearch(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	s := vars["s"]

	resp, ok := gateway.ProductSearch(&pb.SearchRequest{Search: s})

	if !ok {
		// todo send err
		return
	}

	sendJson(w, resp)
}

func GetBrandById(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	brandId, e := strconv.ParseInt(vars["brandId"], 10, 64)

	if e != nil {
		// todo send err
		return
	}

	resp, ok := gateway.GetBrand(&pb.BrandRequest{BrandId: brandId})

	if !ok {
		// todo send err
		return
	}

	sendJson(w, resp)
}

func GetCategoryId(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	categoryId, e := strconv.ParseInt(vars["categoryId"], 10, 64)

	if e != nil {
		// todo send err
		return
	}

	resp, ok := gateway.GetCategory(&pb.CategoryRequest{CategoryId: categoryId})

	if !ok {
		// todo send err
		return
	}

	sendJson(w, resp)
}

func GetProductById(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	productId, e := strconv.ParseInt(vars["productId"], 10, 64)

	if e != nil {
		// todo send err
		return
	}

	resp, ok := gateway.GetProduct(&pb.ProductRequest{ProductId: productId})

	if !ok {
		// todo send err
		return
	}

	sendJson(w, resp)
}

func LatestHandler(w http.ResponseWriter, req *http.Request) {
	resp, ok := gateway.GetLatestItems()

	if !ok {
		log.Println("Failed to get Latest items")
		return
	}

	sendJson(w, resp)
}

func sendJson(w http.ResponseWriter, message proto.Message) {
	m := jsonpb.Marshaler{}
	result, _ := m.MarshalToString(message)

	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	i, e := w.Write([]byte(result))

	if e != nil {
		log.Printf("Failed to write to client!\n%v", e)
	} else {
		log.Printf("Wrote: %d bytes to response", i)
	}
}
