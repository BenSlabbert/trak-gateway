package grpc

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
	"trak-gateway/gateway/response"
)

func BrandSearch(req *pb.SearchRequest) (*pb.SearchResponse, *response.Error) {
	ctx, cancel := withDeadline(5000)
	defer cancel()

	r, e := searchServiceClient.BrandSearch(ctx, req)

	if e != nil {
		log.Warn("Error while getting BrandSearch from searchServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}

func CategorySearch(req *pb.SearchRequest) (*pb.SearchResponse, *response.Error) {
	ctx, cancel := withDeadline(5000)
	defer cancel()

	r, e := searchServiceClient.CategorySearch(ctx, req)

	if e != nil {
		log.Warn("Error while getting CategorySearch from searchServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}

func ProductSearch(req *pb.SearchRequest) (*pb.SearchResponse, *response.Error) {
	ctx, cancel := withDeadline(5000)
	defer cancel()

	r, e := searchServiceClient.ProductSearch(ctx, req)

	if e != nil {
		log.Warn("Error while getting ProductSearch from searchServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}
