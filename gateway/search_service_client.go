package gateway

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
)

func BrandSearch(req *pb.SearchRequest) (*pb.SearchResponse, bool) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := searchServiceClient.BrandSearch(ctx, req)

	if e != nil {
		log.Printf("Error while getting branch search result from searchServiceClient\n%v", e)
		return nil, false
	}

	return r, true
}

func CategorySearch(req *pb.SearchRequest) (*pb.SearchResponse, bool) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := searchServiceClient.CategorySearch(ctx, req)

	if e != nil {
		log.Printf("Error while getting category search result from searchServiceClient\n%v", e)
		return nil, false
	}

	return r, true
}

func ProductSearch(req *pb.SearchRequest) (*pb.SearchResponse, bool) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := searchServiceClient.ProductSearch(ctx, req)

	if e != nil {
		log.Printf("Error while getting product search result from searchServiceClient\n%v", e)
		return nil, false
	}

	return r, true
}
