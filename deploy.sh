#!/bin/bash

set -e

echo "=========================================="
echo "Starting deployment"
echo "=========================================="

if [ -z "$APP_IMAGE" ]; then
    echo "APP_IMAGE is not set."
    exit 1
fi

echo "Deploying image:"
echo "$APP_IMAGE"

docker pull "$APP_IMAGE"

docker compose down

docker compose up -d

sleep 5

echo "Checking containers..."

docker ps

echo "Checking application..."

curl -f http://localhost/ > /dev/null

echo "=========================================="
echo "Deployment successful"
echo "=========================================="
