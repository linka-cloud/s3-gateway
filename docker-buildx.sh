#!/bin/bash

sudo sysctl net.ipv6.conf.all.disable_ipv6=0

release=$(git describe --abbrev=0 --tags)

docker buildx build --push --no-cache \
       --build-arg RELEASE="${release}" -t "linkacloud/minio-gateway:latest" \
       --platform=linux/arm64,linux/amd64,linux/ppc64le,linux/s390x \
       -f Dockerfile.release .

docker buildx prune -f

docker buildx build --push --no-cache \
       --build-arg RELEASE="${release}" -t "ghcr.io/linka-cloud/minio-gateway:latest" \
       --platform=linux/arm64,linux/amd64,linux/ppc64le,linux/s390x \
       -f Dockerfile.release .

docker buildx prune -f

docker buildx build --push --no-cache \
       --build-arg RELEASE="${release}" -t "linkacloud/minio-gateway:${release}" \
       --platform=linux/arm64,linux/amd64,linux/ppc64le,linux/s390x \
       -f Dockerfile.release .

docker buildx prune -f

docker buildx build --push --no-cache \
       --build-arg RELEASE="${release}" -t "ghcr.io/linka-cloud/minio-gateway:${release}" \
       --platform=linux/arm64,linux/amd64,linux/ppc64le,linux/s390x \
       -f Dockerfile.release .

docker buildx prune -f

docker buildx build --push --no-cache \
       --build-arg RELEASE="${release}" -t "linkacloud/minio-gateway:${release}.fips" \
       --platform=linux/amd64 -f Dockerfile.release.fips .

docker buildx prune -f

docker buildx build --push --no-cache \
       --build-arg RELEASE="${release}" -t "ghcr.io/linka-cloud/minio-gateway:${release}.fips" \
       --platform=linux/amd64 -f Dockerfile.release.fips .

docker buildx prune -f

sudo sysctl net.ipv6.conf.all.disable_ipv6=0
