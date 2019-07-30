package gateway

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
)

func GetCategory(req *pb.CategoryRequest) (*pb.BrandResponse, bool) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := categoryServiceClient.Category(ctx, req)

	if e != nil {
		log.Printf("Error while getting category from categoryServiceClient\n%v", e)
		return nil, false
	}

	return r, true
}
