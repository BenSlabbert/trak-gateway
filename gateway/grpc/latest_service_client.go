package grpc

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
	"trak-gateway/gateway/response"
)

func GetLatestItems() (*pb.LatestResponse, *response.Error) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := latestServiceClient.Latest(ctx, &pb.Empty{})
	if e != nil {
		log.Warn("Error while getting Latest from latestServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}
