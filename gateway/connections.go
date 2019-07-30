package gateway

import (
	"context"
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"os"
	"time"
)

var apiClient *grpc.ClientConn
var searchClient *grpc.ClientConn

var brandServiceClient pb.BrandServiceClient
var searchServiceClient pb.SearchServiceClient
var latestServiceClient pb.LatestServiceClient
var productServiceClient pb.ProductServiceClient
var categoryServiceClient pb.CategoryServiceClient
var promotionServiceClient pb.PromotionServiceClient

func init() {
	apiGRPCHost := os.Getenv("API_GRPC_HOST")
	searchGRPCHost := os.Getenv("SEARCH_GRPC_HOST")

	if apiGRPCHost == "" {
		apiGRPCHost = ":50051"
	}

	if searchGRPCHost == "" {
		apiGRPCHost = ":50052"
	}

	var grpcErr error
	apiClient, grpcErr = grpc.Dial(apiGRPCHost, grpc.WithInsecure())

	if grpcErr != nil {
		log.Fatalf("Failed to connect: %v", grpcErr)
	}

	brandServiceClient = pb.NewBrandServiceClient(apiClient)
	latestServiceClient = pb.NewLatestServiceClient(apiClient)
	productServiceClient = pb.NewProductServiceClient(apiClient)
	categoryServiceClient = pb.NewCategoryServiceClient(apiClient)
	promotionServiceClient = pb.NewPromotionServiceClient(apiClient)

	searchClient, grpcErr = grpc.Dial(searchGRPCHost, grpc.WithInsecure())

	if grpcErr != nil {
		log.Fatalf("Failed to connect: %v", grpcErr)
	}

	searchServiceClient = pb.NewSearchServiceClient(searchClient)
}

func withDeadline(millis int) (context.Context, context.CancelFunc) {
	clientDeadline := time.Now().Add(time.Duration(millis) * time.Millisecond)
	return context.WithDeadline(context.Background(), clientDeadline)
}

func CloseConnections() {
	if apiClient != nil {
		e := apiClient.Close()

		if e != nil {
			log.Printf("Failed to close apiClient grpc connection\n%v", e)
		}
	}

	if searchClient != nil {
		e := searchClient.Close()

		if e != nil {
			log.Printf("Failed to close searchClient grpc connection\n%v", e)
		}
	}
}
