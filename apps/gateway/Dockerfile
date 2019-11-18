ARG CODE_PATH=/app/gateway
ARG BUILD_PATH=$CODE_PATH/apps/gateway
ARG APPNAME=gateway
ARG CERT_PATH=/etc/ssl/certs/ca-certificates.crt

########################################################################################################################

FROM golang:1.13.3-alpine3.10 AS builder

ARG CODE_PATH
ARG BUILD_PATH
ARG APPNAME

RUN apk update && apk upgrade && apk add --no-cache git bash openssh ca-certificates

COPY . $CODE_PATH

WORKDIR $CODE_PATH
RUN go mod download

WORKDIR $BUILD_PATH
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o $APPNAME

########################################################################################################################

FROM alpine:3.10 AS alpine

RUN apk update && apk upgrade && apk add --no-cache ca-certificates && rm -rf /var/cache/apk/*
RUN adduser -D -H -u 10001 go-user
RUN mkdir /tmp/static --mode=777
RUN chown -R go-user /tmp/static

ARG BUILD_PATH
ARG APPNAME
ARG CERT_PATH

# Copy binary from builder
COPY --from=builder $BUILD_PATH/$APPNAME app

ENV API_PORT=5000
ENV PROFILE=DOCKER
USER go-user

ENTRYPOINT ["./app"]
