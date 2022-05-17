#!/bin/bash

# Local .env
envString=""
if [ -f .env ]; then
    envString+="--env-file ./.env"
    # Load Environment Variables
    export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

echo "Docker Developer Stack Shutting Down..."
dockerComposeString="-f ./docker/docker-compose.yaml"
dockerComposeString+=" -f ./docker/docker-compose.admin.yaml"
dockerComposeString+=" -f ./docker/docker-compose.caching.yaml"
dockerComposeString+=" -f ./docker/docker-compose.debug.yaml"
# dockerComposeString+=" -f ./docker/docker-compose.debug-wsl2.yaml"

docker-compose ${envString} ${dockerComposeString} down --remove-orphans --rmi local --volumes

# If wordpress has already been installed purge its files.
if [ -d "./public/wp" ]; then
    echo "Purging WordPress core code."
    sudo rm -rf ./public/wp
fi
