#!/bin/bash

VERSION=2.0.0-${TRAVIS_BUILD_NUMBER}

echo "Building Images with version: ${VERSION} travis build number: ${TRAVIS_BUILD_NUMBER}"

docker build -t benjaminslabbert/trak_gateway:"${VERSION}" -f ./apps/ui-server/Dockerfile .
docker build -t benjaminslabbert/trak_worker:"${VERSION}" -f ./apps/worker/takealot/Dockerfile .
docker build -t benjaminslabbert/trak_search:"${VERSION}" -f ./apps/search/sonic/Dockerfile .

echo "#########################"
echo "# Pushing to Docker hub #"
echo "#########################"

echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin

docker push benjaminslabbert/trak_gateway:"${VERSION}"
docker push benjaminslabbert/trak_worker:"${VERSION}"
docker push benjaminslabbert/trak_search:"${VERSION}"
