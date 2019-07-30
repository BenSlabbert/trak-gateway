package gateway

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
)

func AddProduct(req *pb.AddProductRequest) (*pb.AddProductResponse, bool) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := productServiceClient.AddProduct(ctx, req)

	if e != nil {
		log.Printf("Error while adding product from ProductService\n%v", e)
		return nil, false
	}

	return r, true
}

func GetProduct(req *pb.ProductRequest) (*pb.ProductResponse, bool) {
	ctx, cancel := withDeadline(500)
	defer cancel()

	r, e := productServiceClient.Product(ctx, req)

	if e != nil {
		log.Printf("Error while getting product from ProductService\n%v", e)
		return nil, false
	}

	return r, true
}
