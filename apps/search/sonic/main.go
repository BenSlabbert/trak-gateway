package main

import (
	"context"
	"fmt"
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"github.com/golang/protobuf/proto"
	"github.com/google/uuid"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"net"
	"os"
	"os/signal"
	"trak-gateway/search"
	"trak-gateway/takealot/queue"
)

func run() error {
	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

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
	pb.RegisterSearchServiceServer(s, &search.GRPCServer{SonicSearch: sonicSearch})

	// Register reflection service on gRPC server.
	reflection.Register(s)

	go func() {
		log.Infof("Starting gRPC server")
		if err := s.Serve(lis); err != nil {
			log.Fatalf("Failed to server: %v", err)
		}
	}()

	// todo created nsq consumer for sonic digest
	c := queue.CreateNSQConsumer(fmt.Sprintf("%s-nsq-product-digest", uuid.New().String()[:6]), queue.ProductDigestQueue, "sonic")
	c.AddHandler(nsq.HandlerFunc(HandleNSQProductDigest))
	queue.ConnectConsumer(c)
	defer c.Stop()

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

	return nil
}

func HandleNSQProductDigest(message *nsq.Message) error {
	var messageIDBytes []byte
	for _, b := range message.ID {
		messageIDBytes = append(messageIDBytes, b)
	}
	messageID := string(messageIDBytes)

	sr := &pb.SearchResult{}
	e := proto.Unmarshal(message.Body, sr)

	if e != nil {
		log.Warnf("%s: failed to unmarshal message to proto", messageID)
	}

	sonicSearch, err := search.CreateSonicSearch()

	if err != nil {
		log.Errorf("failed to create sonic connection: %v", err)
		return err
	}

	defer sonicSearch.Quit()

	e = sonicSearch.Ingest(search.ProductCollection, search.ProductBucket, sr.Id, sr.Name)

	if e != nil {
		log.Errorf("failed to ingest %s:%s into sonic: %v", sr.Id, sr.Name, err)
		return err
	}

	return nil
}

func main() {
	if err := run(); err != nil {
		log.Fatalf("filed to run application: %v", err)
	}
}
