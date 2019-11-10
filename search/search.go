package search

import (
	pb "github.com/BenSlabbert/trak-gRPC/src/go"
	"github.com/golang/protobuf/proto"
	"github.com/nsqio/go-nsq"
	log "github.com/sirupsen/logrus"
	"trak-gateway/takealot/queue"
)

type NSQProductDigest struct {
	SonicSearch *SonicSearch
}

func (d *NSQProductDigest) Quit() {
	d.SonicSearch.Quit()
}

func (d *NSQProductDigest) HandleNSQMessage(message *nsq.Message) error {
	messageID := queue.MessageIDString(message.ID)

	sr := &pb.SearchResult{}
	e := proto.Unmarshal(message.Body, sr)

	if e != nil {
		log.Warnf("%s: failed to unmarshal message to proto", messageID)
	}

	log.Infof("%s: digesting product: %s", messageID, sr.Name)
	e = d.SonicSearch.Ingest(ProductCollection, ProductBucket, sr.Id, sr.Name)

	if e != nil {
		log.Errorf("failed to ingest %s:%s into sonic: %v", sr.Id, sr.Name, e)
		return e
	}

	return nil
}

type NSQBrandDigest struct {
	SonicSearch *SonicSearch
}

func (d *NSQBrandDigest) Quit() {
	d.SonicSearch.Quit()
}

func (d *NSQBrandDigest) HandleNSQMessage(message *nsq.Message) error {
	messageID := queue.MessageIDString(message.ID)

	sr := &pb.SearchResult{}
	e := proto.Unmarshal(message.Body, sr)

	if e != nil {
		log.Warnf("%s: failed to unmarshal message to proto", messageID)
	}

	log.Infof("%s: digesting brand: %s", messageID, sr.Name)
	e = d.SonicSearch.Ingest(BrandCollection, BrandBucket, sr.Id, sr.Name)

	if e != nil {
		log.Errorf("failed to ingest %s:%s into sonic: %v", sr.Id, sr.Name, e)
		return e
	}

	return nil
}

type NSQCategoryDigest struct {
	SonicSearch *SonicSearch
}

func (d *NSQCategoryDigest) Quit() {
	d.SonicSearch.Quit()
}

func (d *NSQCategoryDigest) HandleNSQMessage(message *nsq.Message) error {
	messageID := queue.MessageIDString(message.ID)

	sr := &pb.SearchResult{}
	e := proto.Unmarshal(message.Body, sr)

	if e != nil {
		log.Warnf("%s: failed to unmarshal message to proto", messageID)
	}

	log.Infof("%s: digesting category: %s", messageID, sr.Name)
	e = d.SonicSearch.Ingest(CategoryCollection, CategoryBucket, sr.Id, sr.Name)

	if e != nil {
		log.Errorf("failed to ingest %s:%s into sonic: %v", sr.Id, sr.Name, e)
		return e
	}

	return nil
}
