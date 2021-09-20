#!/bin/bash

echo "Docker Developer Stack Shutting Down..."
dockerComposeString="-f ./docker/docker-compose.yaml"
dockerComposeString+=" -f ./docker/docker-compose.admin.yaml"
dockerComposeString+=" -f ./docker/docker-compose.caching.yaml"
dockerComposeString+=" -f ./docker/docker-compose.debug.yaml"
# dockerComposeString+=" -f ./docker/docker-compose.debug-wsl2.yaml"

docker-compose ${dockerComposeString} --env-file=./.env down