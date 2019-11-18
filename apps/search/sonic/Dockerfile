ARG CODE_PATH=/app/search
ARG BUILD_PATH=$CODE_PATH/apps/search/sonic
ARG APPNAME=search
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

########################################################################################################################

FROM scratch

ARG BUILD_PATH
ARG APPNAME
ARG CERT_PATH

COPY --from=alpine $CERT_PATH /etc/ssl/certs/
COPY --from=alpine /etc/passwd /etc/passwd

# Copy binary from builder
COPY --from=builder $BUILD_PATH/$APPNAME app

USER go-user

ENTRYPOINT ["./app"]
