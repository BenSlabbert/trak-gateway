package search

import (
	"context"
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type GRPCServer struct {
	SonicSearch *SonicSearch
}

func (g GRPCServer) BrandSearch(ctx context.Context, req *pb.SearchRequest) (*pb.SearchResponse, error) {
	res, e := g.SonicSearch.Query(BrandCollection, BrandBucket, req.Search, 10, 0)
	if e != nil {
		return nil, status.Errorf(codes.Internal, "error while querying sonic: %s", e.Error())
	}
	return buildResponse(res), nil
}

func (g GRPCServer) ProductSearch(ctx context.Context, req *pb.SearchRequest) (*pb.SearchResponse, error) {
	res, e := g.SonicSearch.Query(ProductCollection, ProductBucket, req.Search, 10, 0)
	if e != nil {
		return nil, status.Errorf(codes.Internal, "error while querying sonic: %s", e.Error())
	}
	return buildResponse(res), nil
}

func (g GRPCServer) CategorySearch(ctx context.Context, req *pb.SearchRequest) (*pb.SearchResponse, error) {
	res, e := g.SonicSearch.Query(CategoryCollection, CategoryBucket, req.Search, 10, 0)
	if e != nil {
		return nil, status.Errorf(codes.Internal, "error while querying sonic: %s", e.Error())
	}
	return buildResponse(res), nil
}

func buildResponse(res []string) *pb.SearchResponse {
	var results []*pb.SearchResult
	for _, r := range res {
		results = append(results, &pb.SearchResult{Name: r, Id: r})
	}
	return &pb.SearchResponse{
		Results: results,
	}
}
