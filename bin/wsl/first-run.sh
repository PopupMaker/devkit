#!/bin/bash

refresh_screen() {
    clear
    echo Welcome to the Code Atlantic Project Box.
    echo "-------------------------------------------------"
    echo ""
}

refresh_screen

countdown() {
    str=${str:-"."}
    count=${count:-3}
    delay=${delay:-0.5}

    # Map named parameters
    while [ $# -gt 0 ]; do
        if [[ $1 == *"--"* ]]; then
            param="${1/--/}"
            declare $param="$2"
            # echo $1 $2 // Optional to see the parameter:value result
        fi

        shift
    done

    for pc in $(seq 1 $count); do
        v=$(printf "%-${pc}s" "$str")

        echo -ne "${v// /$str}"\\r
        sleep $delay
    done
}

# sudo chown $(whoami) ../../data/db
# sudo chgrp $(whoami) ../../data/db

# Handle git config.
./first-run/git-config.sh

countdown --count 3

# Handle SSH keys.
./first-run/ssh-keys.sh

countdown --count 3
