# trak

The app is live [app.trak-app.co.za](https://app.trak-app.co.za/)

## Backend

This repo contains the backend for the trak-app 

## Frontend

The frontend can be found here: [trak-ui](https://github.com/BenSlabbert/trak-ui)

## Message serialization Definitions

Trak uses [protobuf](https://github.com/protocolbuffers/protobuf/) and [grpc](https://github.com/protocolbuffers/protobuf/) (internally), the proto files can be found at [trak-grpc](https://github.com/BenSlabbert/trak-grpc).

The [trak-ui](https://github.com/BenSlabbert/trak-ui) does **not** use JSON, but serializes/de-serializes binary [protobuf](https://github.com/protocolbuffers/protobuf/) messages.

### NSQ

Get stats with the CLI. SSH into the NSQ node then run:

```shell script
./nsq_stat --topic new-product-queue --channel worker --nsqd-http-address 127.0.0.1:4151
```

Specify the `topic` and `channel` to pull stats from
