#!/bin/bash

# Local .env
envString=""
if [ -f .env ]; then
    envString+="--env-file ./.env"
    # Load Environment Variables
    export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Run the needed docker containers."
   echo
   echo "Syntax: bash ./docker-up.sh [-a|c|d]"
   echo "options:"
   echo "-a|--admin     Enable admin tools for DB management."
   echo "-c|--caching   Enable caching services."
   echo "-d|--debug     Enable debugging."
   echo
}

############################################################
# Process the input options. Add options as needed.        #
############################################################
while [ $# -gt 0 ]; do
  case "$1" in
    -a|--admin) admin=true ;;
    -c|--caching) caching=true ;;
    -d|--debug) debug=true ;;
    \?|--help) Help ;;
  esac
  shift
done

echo "Docker Developer Stack Launching..."
dockerComposeString="-f ./docker/docker-compose.yaml"

if [ -n "${admin}" ]; then
    echo "Admin Tool Configs Loaded..."
    dockerComposeString+=" -f ./docker/docker-compose.admin.yaml"
fi

if [ -n "${caching}" ]; then
    echo "Caching Services Loaded..."
    dockerComposeString+=" -f ./docker/docker-compose.caching.yaml"
fi

if [ -n "${debug}" ]; then
    echo "Debug Tools Enabled..."
    dockerComposeString+=" -f ./docker/docker-compose.debug.yaml"

    # If this is WSL environment, load additional docker configs.
    # set -e
    # if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    #     echo "WSL Detected: Extra Configs Loaded..."
    #     # dockerComposeString+=" -f ./docker/docker-compose.debug-wsl2.yaml"
    #     if [[ -z "${IP}" ]]; then
    #         export IP=$(hostname -I)
    #     fi
    # fi;
fi

# If wordpress has already been installed.
remove_old_wp_files=false
if [ -d "./public/wp" ]; then

    if [ -f "./public/wp/wp-includes/version.php" ]; then

        VOLUME_VERSION="$(php -r 'require('"'"'./public/wp/wp-includes/version.php'"'"'); echo $wp_version;')"

        # remove beta- or -alpha prefix and -RC[0-9] suffix.
        VOLUME_VERSION=${VOLUME_VERSION#beta-}
        VOLUME_VERSION=${VOLUME_VERSION%-*}
        TARGET_VERSION=${WP_VERSION#beta-}
        TARGET_VERSION=${TARGET_VERSION%-*}

        echo "Volume version : "$VOLUME_VERSION
        echo "WordPress version : "$TARGET_VERSION

        if [ "$VOLUME_VERSION" != "$TARGET_VERSION" ]; then
            remove_old_wp_files=true
        fi
    fi
fi

if [ $remove_old_wp_files = true ]; then
    echo "Forcing WordPress code update..."
    sudo rm -rf ./public/wp
fi

docker-compose ${envString} ${dockerComposeString} rm wordpress
docker-compose ${envString} ${dockerComposeString} build wordpress --pull --no-cache --progress=plain
docker-compose ${envString} ${dockerComposeString} up wordpress -d
