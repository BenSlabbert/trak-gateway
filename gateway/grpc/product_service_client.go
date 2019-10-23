package grpc

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
	"trak-gateway/gateway/response"
)

func AddProduct(req *pb.AddProductRequest) (*pb.AddProductResponse, *response.Error) {
	ctx, cancel := withDeadline(1000)
	defer cancel()

	r, e := productServiceClient.AddProduct(ctx, req)

	if e != nil {
		log.Warn("Error while getting AddProduct from productServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}

func GetProduct(req *pb.ProductRequest) (*pb.ProductResponse, *response.Error) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := productServiceClient.Product(ctx, req)

	if e != nil {
		log.Warn("Error while getting Product from productServiceClient")
		return nil, parseError(e)
	}

	return r, nil
}
