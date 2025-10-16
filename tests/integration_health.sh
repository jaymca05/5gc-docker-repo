#!/bin/bash
set -e

echo "🚀 Starting Open5GS stack for integration tests..."

# 🧠 Check if BASE_IMAGE_NAME is set, otherwise prompt user
if [ -z "${BASE_IMAGE_NAME}" ]; then
  echo "⚠️  BASE_IMAGE_NAME is not set!"
  echo "👉 Please export it before running, for example:"
  echo "   export BASE_IMAGE_NAME=open5gs-base:latest"
  echo "Or run this script as:"
  echo "   BASE_IMAGE_NAME=open5gs-base:latest ./tests/integration_health.sh"
  exit 1
else
  echo "🧩 Using BASE_IMAGE_NAME=${BASE_IMAGE_NAME}"
fi

# 🛠️ Build all services using the provided base image
echo "🏗️  Building Docker images..."
#docker-compose build --build-arg BASE_IMAGE_NAME="${BASE_IMAGE_NAME}"

# 🚀 Start containers
echo "🔧 Starting containers..."
#docker-compose up -d

# Wait for NRF to be ready
echo "⏳ Waiting for NRF to be ready..."
RETRIES=100
until curl -sf http2://localhost:7777/nnrf-nfm/v1/nf-instances >/dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
#until docker exec open5gs-docker-nrf-1 curl -sf http://127.0.0.10:7777/nnrf-nfm/v1/nf-instances >/dev/null 2>&1; do
  sleep 2
  RETRIES=$((RETRIES - 1))
  echo $RETRIES
done

if [ $RETRIES -eq 0 ]; then
  echo "❌ NRF did not become ready in time!"
  docker-compose logs nrf
  docker-compose down
  exit 1
fi

echo "✅ NRF is up!"

# Check container logs for errors
python3 tests/check_logs.py || {
  echo "❌ Log check failed"
  docker-compose down
  exit 1
}

# Verify NRF has registered instances
echo "🧠 Checking NRF registration..."
#if ! docker exec open5gs-docker-nrf-1 curl -sf http://127.0.0.10:7777/nnrf-nfm/v1/nf-instances | jq '. | length' | grep -vq "0"; then
if ! curl -sf http://localhost:7777/nnrf-nfm/v1/nf-instances | jq '. | length' | grep -vq "0"; then
  echo "❌ No NFs registered with NRF!"
  docker-compose down
  exit 1
fi

echo "✅ All network functions registered successfully!"
echo "🧹 Cleaning up..."
#docker-compose down

echo "🎉 Integration test PASSED!"

