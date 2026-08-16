#!/bin/bash

set -e

CONTAINER_NAME="devops-build"
IMAGE_NAME="devops-build"
IMAGE_TAG="latest"

echo "========================================"
echo "Starting application deployment"
echo "========================================"

echo "Container: ${CONTAINER_NAME}"
echo "Image: ${IMAGE_NAME}:${IMAGE_TAG}"

echo "Stopping existing container..."

docker compose down || true

echo "Starting application..."

docker compose up -d

echo "========================================"
echo "Deployment completed successfully"
echo "========================================"

echo "Container status:"
docker compose ps

echo "Application health check:"
curl -f http://localhost > /dev/null

echo "Application is UP and responding on port 80."
