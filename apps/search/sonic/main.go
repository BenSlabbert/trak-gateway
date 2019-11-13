package main

import (
	"context"
	"fmt"
	pb "github.com/BenSlabbert/trak-gRPC/gen/go/proto/search"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	_ "google.golang.org/grpc/encoding/gzip"
	"google.golang.org/grpc/reflection"
	"net"
	"net/http"
	"os"
	"os/signal"
	"trak-gateway/gateway/metrics"
	"trak-gateway/search"
	"trak-gateway/takealot/env"
	"trak-gateway/takealot/queue"
)

func run() error {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	takealotEnv := env.LoadEnv()
	if takealotEnv.PPROFEnv.PPROFEnabled {
		log.Infof("exposing pprof on port: %d", takealotEnv.PPROFEnv.PPROFPort)
		router := mux.NewRouter()
		metrics.ExposePPROF(router)
		go func() {
			err := http.ListenAndServe(fmt.Sprintf(":%d", takealotEnv.PPROFEnv.PPROFPort), router)
			log.Warnf("failed to serve on port %d: %v", takealotEnv.PPROFEnv.PPROFPort, err)
		}()
	}

	serverPort := os.Getenv("GRPC_PORT")

	if serverPort == "" {
		serverPort = "50052"
	}

	// register gRPC server
	lis, err := net.Listen("tcp", fmt.Sprintf(":%s", serverPort))

	if err != nil {
		log.Errorf("Failed to listen : %v", err)
		return err
	}

	sonicSearch, err := search.CreateSonicSearch()

	if err != nil {
		log.Errorf("failed to create sonic connection: %v", err)
		return err
	}
	defer sonicSearch.Quit()

	s := grpc.NewServer()
	pb.RegisterSearchAPIServer(s, &search.GRPCServer{SonicSearch: sonicSearch})

	// Register reflection service on gRPC server.
	reflection.Register(s)

	go func() {
		log.Infof("Starting gRPC server")
		if err := s.Serve(lis); err != nil {
			log.Fatalf("Failed to server: %v", err)
		}
	}()

	createSonicSearch, err := search.CreateSonicSearch()
	if err != nil {
		log.Fatalf("failed ot create sonic search pool: %v", err)
	}

	productDigest := &search.NSQProductDigest{SonicSearch: createSonicSearch}
	brandDigest := &search.NSQBrandDigest{SonicSearch: createSonicSearch}
	categoryDigest := &search.NSQCategoryDigest{SonicSearch: createSonicSearch}
	defer productDigest.Quit()

	consumers := make([]*nsq.Consumer, 0)
	c := queue.CreateNSQConsumer(fmt.Sprintf("%s-nsq-product-digest", uuid.New().String()[:6]), queue.ProductDigestQueue, "sonic-product")
	c.AddHandler(nsq.HandlerFunc(productDigest.HandleNSQMessage))
	queue.ConnectConsumer(c)
	consumers = append(consumers, c)

	c = queue.CreateNSQConsumer(fmt.Sprintf("%s-nsq-brand-digest", uuid.New().String()[:6]), queue.BrandDigestQueue, "sonic-brand")
	c.AddHandler(nsq.HandlerFunc(brandDigest.HandleNSQMessage))
	queue.ConnectConsumer(c)
	consumers = append(consumers, c)

	c = queue.CreateNSQConsumer(fmt.Sprintf("%s-nsq-category-digest", uuid.New().String()[:6]), queue.CategoryDigestQueue, "sonic-category")
	c.AddHandler(nsq.HandlerFunc(categoryDigest.HandleNSQMessage))
	queue.ConnectConsumer(c)
	consumers = append(consumers, c)

	// wait for Ctrl + C to exit
	ch := make(chan os.Signal, 1)
	signal.Notify(ch, os.Interrupt)
	signal.Notify(ch, os.Kill)

	// Block until signal is received
	sig := <-ch

	log.Infof("Stopping the server. OS Signal: %v", sig)
	s.GracefulStop()

	log.Infof("Closing the listener")
	_ = lis.Close()

	for _, consumer := range consumers {
		consumer.Stop()
	}

	return nil
}

func main() {
	if err := run(); err != nil {
		log.Fatalf("failed to run application: %v", err)
	}
}
