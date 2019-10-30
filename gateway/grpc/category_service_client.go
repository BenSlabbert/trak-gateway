package grpc

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
	"trak-gateway/gateway/response"
)

func GetCategory(req *pb.CategoryRequest) (*pb.BrandResponse, *response.Error) {
	ctx, cancel := withDeadline(5000)
	defer cancel()

	r, e := categoryServiceClient.Category(ctx, req)

	if e != nil {
		log.Warn("Error while getting Category from categoryServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}
