package gateway

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
)

func GetPromotion(req *pb.PromotionRequest) (*pb.PromotionResponse, bool) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := promotionServiceClient.Promotions(ctx, req)

	if e != nil {
		log.Printf("Error while getting promotion from promotionServiceClient\n%v", e)
		return nil, false
	}

	return r, true
}
