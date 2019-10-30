package grpc

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
	"trak-gateway/gateway/response"
)

func GetBrand(req *pb.BrandRequest) (*pb.BrandResponse, *response.Error) {
	ctx, cancel := withDeadline(5000)
	defer cancel()

	r, e := brandServiceClient.Brand(ctx, req)

	if e != nil {
		log.Warn("Error while getting Brand from brandServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}
