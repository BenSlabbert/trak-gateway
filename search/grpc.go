package search

import (
	"context"
	pb "github.com/BenSlabbert/trak-gRPC/gen/go/proto/search"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type GRPCServer struct {
	SonicSearch *SonicSearch
}

func (g GRPCServer) BrandSearch(ctx context.Context, req *pb.BrandSearchRequest) (*pb.BrandSearchResponse, error) {
	res, e := g.SonicSearch.Query(BrandCollection, BrandBucket, req.Search, 20, 0)
	if e != nil {
		return nil, status.Errorf(codes.Internal, "error while querying sonic: %s", e.Error())
	}

	return &pb.BrandSearchResponse{
		Results: appendResults(res),
	}, nil
}

func (g GRPCServer) ProductSearch(ctx context.Context, req *pb.ProductSearchRequest) (*pb.ProductSearchResponse, error) {
	res, e := g.SonicSearch.Query(ProductCollection, ProductBucket, req.Search, 20, 0)
	if e != nil {
		return nil, status.Errorf(codes.Internal, "error while querying sonic: %s", e.Error())
	}

	return &pb.ProductSearchResponse{
		Results: appendResults(res),
	}, nil
}

func (g GRPCServer) CategorySearch(ctx context.Context, req *pb.CategorySearchRequest) (*pb.CategorySearchResponse, error) {
	res, e := g.SonicSearch.Query(CategoryCollection, CategoryBucket, req.Search, 20, 0)
	if e != nil {
		return nil, status.Errorf(codes.Internal, "error while querying sonic: %s", e.Error())
	}

	return &pb.CategorySearchResponse{
		Results: appendResults(res),
	}, nil
}

func appendResults(res []string) []*pb.SearchResult {
	results := make([]*pb.SearchResult, 0)
	for _, r := range res {
		results = append(results, &pb.SearchResult{
			Id:    r,
			Text:  r,
			Score: 0,
		})
	}
	return results
}
