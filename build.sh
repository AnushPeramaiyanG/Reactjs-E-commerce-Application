#!/bin/bash

set -e

IMAGE_NAME="devops-build"
IMAGE_TAG="latest"

echo "========================================"
echo "Starting Docker image build"
echo "========================================"

echo "Image: ${IMAGE_NAME}:${IMAGE_TAG}"

docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" .

echo "========================================"
echo "Docker image built successfully"
echo "========================================"

docker images "${IMAGE_NAME}"
