#!/bin/bash

# Local .env
if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

echo "Docker Developer Stack Shutting Down..."
dockerComposeString="-f ./docker/docker-compose.yaml"
dockerComposeString+=" -f ./docker/docker-compose.admin.yaml"
dockerComposeString+=" -f ./docker/docker-compose.caching.yaml"
dockerComposeString+=" -f ./docker/docker-compose.debug.yaml"
# dockerComposeString+=" -f ./docker/docker-compose.debug-wsl2.yaml"

docker-compose ${dockerComposeString} down