#!/usr/bin/env bash

docker buildx build --platform linux/386,linux/amd64,linux/arm64 -t "moveyourdigital/bootstrap-email-api:${1:-latest}" -f Dockerfile  . --push
