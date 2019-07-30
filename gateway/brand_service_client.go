package gateway

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
)

func GetBrand(req *pb.BrandRequest) (*pb.BrandResponse, bool) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := brandServiceClient.Brand(ctx, req)

	if e != nil {
		log.Printf("Error while getting brand from brandServiceClient\n%v", e)
		return nil, false
	}

	return r, true
}
