#!/usr/bin/env bash

if [ $# -eq 0 ]
  then
    echo "Must provide the git commit hash"
  exit 1
fi

go get github.com/BenSlabbert/trak-gRPC@"$1"
