#!/usr/bin/env bash
set -e
set -x
IMAGE=$1
. version.properties
docker tag $IMAGE:latest $IMAGE:$IMAGE_VERSION
docker push $IMAGE:$IMAGE_VERSION
docker rmi $IMAGE:$IMAGE_VERSION