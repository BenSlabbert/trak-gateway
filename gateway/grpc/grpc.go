package grpc

import (
	"context"
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	log "github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/encoding/gzip"
	"google.golang.org/grpc/status"
	"os"
	"time"
	"trak-gateway/gateway/response"
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
	apiClient, grpcErr = grpc.Dial(apiGRPCHost, grpc.WithInsecure(), grpc.WithDefaultCallOptions(grpc.UseCompressor(gzip.Name)))

	if grpcErr != nil {
		log.Fatalf("Failed to connect: %v", grpcErr)
	}

	brandServiceClient = pb.NewBrandServiceClient(apiClient)
	latestServiceClient = pb.NewLatestServiceClient(apiClient)
	productServiceClient = pb.NewProductServiceClient(apiClient)
	categoryServiceClient = pb.NewCategoryServiceClient(apiClient)
	promotionServiceClient = pb.NewPromotionServiceClient(apiClient)

	searchClient, grpcErr = grpc.Dial(searchGRPCHost, grpc.WithInsecure(), grpc.WithDefaultCallOptions(grpc.UseCompressor(gzip.Name)))

	if grpcErr != nil {
		log.Fatalf("Failed to connect: %v", grpcErr)
	}

	searchServiceClient = pb.NewSearchServiceClient(searchClient)
}

func parseError(err error) *response.Error {
	if e, ok := status.FromError(err); ok {
		switch e.Code() {
		case codes.PermissionDenied:
			return permissionDenied(e)
		case codes.Internal:
			return internalError(e)
		case codes.Aborted:
			return aborted(e)
		case codes.Unimplemented:
			return unimplemented(e)
		default:
			return unspecified(e)
		}
	} else {
		log.Warnf("not able to parse error returned %v", err)
		return &response.Error{Message: "Unknown error", Type: response.BadRequest}
	}
}

func unspecified(e *status.Status) *response.Error {
	log.Warnf("gRPC Error:\nCode: %s\nMessage: %s", e.Code(), e.Message())
	return &response.Error{Message: e.Message(), Type: response.BadRequest}
}

func unimplemented(e *status.Status) *response.Error {
	log.Warnf("gRPC Unimplemented Call Error:\nCode: %s\nMessage: %s", e.Code(), e.Message())
	return &response.Error{Message: "API is Unimplemented", Type: response.ServerError}
}

func aborted(e *status.Status) *response.Error {
	log.Warnf("gRPC Aborted Call Error:\nCode: %s\nMessage: %s", e.Code(), e.Message())
	return &response.Error{Message: "Request took too long to complete", Type: response.ServerError}
}

func internalError(e *status.Status) *response.Error {
	log.Warnf("gRPC Internal Error:\nCode: %s\nMessage: %s", e.Code(), e.Message())
	return &response.Error{Message: "Internal Error", Type: response.ServerError}
}

func permissionDenied(e *status.Status) *response.Error {
	log.Warnf("gRPC Permission Denied Error:\nCode: %s\nMessage: %s", e.Code(), e.Message())
	return &response.Error{Message: "Permission Denied", Type: response.PermissionDenied}
}

func withDeadline(millis int) (context.Context, context.CancelFunc) {
	clientDeadline := time.Now().Add(time.Duration(millis) * time.Millisecond)
	return context.WithDeadline(context.Background(), clientDeadline)
}

func CloseConnections() {
	log.Infof("Closing gRPC connections...")

	if apiClient != nil {
		e := apiClient.Close()

		if e != nil {
			log.Warnf("Failed to close apiClient grpc connection\n%v", e)
		}
	}

	if searchClient != nil {
		e := searchClient.Close()

		if e != nil {
			log.Warnf("Failed to close searchClient grpc connection\n%v", e)
		}
	}

	log.Infof("Closing gRPC connections...Done")
}
