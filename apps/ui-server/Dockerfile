ARG CODE_PATH=/app/gateway
ARG BUILD_PATH=$CODE_PATH/apps/ui-server
ARG APPNAME=gateway
ARG CERT_PATH=/etc/ssl/certs/ca-certificates.crt

########################################################################################################################

FROM golang:1.12.7-alpine3.10 AS builder

ARG CODE_PATH
ARG BUILD_PATH
ARG APPNAME

RUN apk update && apk upgrade && apk add --no-cache git bash openssh ca-certificates

COPY . $CODE_PATH

WORKDIR $CODE_PATH
RUN go mod download

WORKDIR $BUILD_PATH
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o $APPNAME

WORKDIR /
RUN mkdir static
WORKDIR /static

RUN wget -O ui.zip https://github.com/BenSlabbert/trak-ui/releases/download/v1.1.0/ui.zip
RUN unzip ui.zip && rm ui.zip

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

# Copy ReactJS Bundle from builder
COPY --from=builder /static /static

ENV API_PORT=5000
ENV PROFILE=DOCKER
ENV STATIC_FILES_DIR=/static
# todo get latest bundle from github
USER go-user

ENTRYPOINT ["./app"]
