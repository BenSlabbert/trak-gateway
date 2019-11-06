package search

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"github.com/golang/protobuf/proto"
	"github.com/nsqio/go-nsq"
	"github.com/prometheus/common/log"
)

type NSQProductDigest struct {
	SonicSearch *SonicSearch
}

func (d *NSQProductDigest) Quit() {
	d.SonicSearch.Quit()
}

func (d *NSQProductDigest) HandleNSQProductDigest(message *nsq.Message) error {
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

	e = d.SonicSearch.Ingest(ProductCollection, ProductBucket, sr.Id, sr.Name)

	if e != nil {
		log.Errorf("failed to ingest %s:%s into sonic: %v", sr.Id, sr.Name, e)
		return e
	}

	return nil
}
