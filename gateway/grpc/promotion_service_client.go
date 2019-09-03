package grpc

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
	"trak-gateway/gateway/response"
)

func GetPromotion(req *pb.PromotionRequest) (*pb.PromotionResponse, *response.Error) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := promotionServiceClient.GetPromotion(ctx, req)

	if e != nil {
		log.Warn("Error while getting Promotions from promotionServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}

func GetAllPromotions(req *pb.GetAllPromotionsRequest) (*pb.GetAllPromotionsResponse, *response.Error) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := promotionServiceClient.GetAllPromotions(ctx, req)

	if e != nil {
		log.Warn("Error while GetAllPromotions from promotionServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}
