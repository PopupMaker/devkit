#!/bin/bash

. .env

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
    dockerComposeString+=" -f ./docker/docker-compose.admin.yaml"
fi

if [ -n "${caching}" ]; then
    dockerComposeString+=" -f ./docker/docker-compose.caching.yaml"
fi

if [ -n "${debug}" ]; then
    dockerComposeString+=" -f ./docker/docker-compose.debug.yaml"

    # If this is WSL environment, load additional docker configs.
    set -e
    if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
        echo "WSL Detected: Extra Configs Loaded"
        dockerComposeString+=" -f ./docker/docker-compose.debug-wsl2.yaml"
        if [[ -z "${IP}" ]]; then
            export IP=$(hostname -I)
        fi
    fi;
fi

# If wordpress has already been installed.
remove_old_wp_files=false

if [ -d "./public/wp" ]; then

    if [ -f "./public/wp/wp-includes/version.php" ]; then

        VOLUME_VERSION="$(php -r 'require('"'"'./public/wp/wp-includes/version.php'"'"'); echo $wp_version;')"
        VOLUME_VERSION=${VOLUME_VERSION%.*}
        TARGET_VERSION=${WP_VERSION%.*}

        echo "Volume version : "$VOLUME_VERSION
        echo "WordPress version : "$TARGET_VERSION

        if [ $VOLUME_VERSION != $WORDPRESS_VERSION ]; then
            remove_old_wp_files=true
        fi
    fi
fi

if [ remove_old_wp_files == true ]; then
    echo "Forcing WordPress code update..."
    rm -rf ./public/wp
fi

docker-compose ${dockerComposeString} up --build -d