#!/bin/bash

VERSION=1.0.1-$(date +%s)

echo "Building Images with version: ${VERSION}"

docker build -t benjaminslabbert/trak_gateway:"${VERSION}" -f ./apps/ui-server/Dockerfile .

echo "#########################"
echo "# Pushing to Docker hub #"
echo "#########################"

echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin

docker push benjaminslabbert/trak_logstash:"${VERSION}"
