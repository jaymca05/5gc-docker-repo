#!/usr/bin/env bash
set -e
#export DOCKER_BUILDKIT=1
# Stop and remove any existing containers / networks / volumes (optional)
#docker compose down
docker-compose down

# Rebuild all images from scratch (no cache), also pull fresh base images
#docker compose build --no-cache --pull
#docker-compose build --no-cache --pull

cd base
docker build -t open5gs-base:latest .
cd ..
docker-compose build --no-cache
#docker-compose build --no-cache --pull
# Bring up containers, forcing recreation
#docker compose up --force-recreate --build
docker-compose up 

