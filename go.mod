module trak-gateway

go 1.12

require (
	github.com/BenSlabbert/trak-gRPC v0.0.0-20191022085631-852ea30eb6f8
	github.com/bsm/redislock v0.4.0
	github.com/go-redis/redis v6.15.6+incompatible
	github.com/go-resty/resty/v2 v2.1.0
	github.com/golang/protobuf v1.3.1
	github.com/google/uuid v1.1.1
	github.com/gorilla/mux v1.7.3
	github.com/jinzhu/gorm v1.9.11
	github.com/nsqio/go-nsq v1.0.7
	github.com/prometheus/common v0.2.0
	github.com/sirupsen/logrus v1.4.2
	google.golang.org/grpc v1.22.1
)
