package gateway

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
)

func GetLatestItems() (*pb.LatestResponse, bool) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := latestServiceClient.Latest(ctx, &pb.Empty{})

	if e != nil {
		log.Printf("Error while getting latest items from LatestService\n%v", e)
		return nil, false
	}

	return r, true
}
