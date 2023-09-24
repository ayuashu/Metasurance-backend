#!/bin/bash
DOCKER_COMPOSE_FILE="/home/ubuntu/Metasurance-backend/docker-compose-cli.yaml"
echo "Stopping containers... "
docker-compose -f "$DOCKER_COMPOSE_FILE" down --volumes --remove-orphans
docker network prune
# Check if the directory exists before attempting to remove it
if [ -d "./channel-artifacts" ]; then
    rm -r ./channel-artifacts
fi
