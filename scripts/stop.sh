#!/bin/bash

echo "Stopping containers... "
docker-compose -f docker-compose-cli.yaml down --volumes --remove-orphans
docker network prune
#rm -r ./crypto-config
rm -r ./channel-artifacts