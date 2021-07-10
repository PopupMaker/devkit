#!/bin/bash
refresh_screen() {
    clear
    echo Popup Maker Project Setup
    echo "-------------------------------------------------"
    echo ""
}

base_path=./app
symlink_dir=./public/content/plugins

refresh_screen

options=("Popup Analytics" "Advanced Targeting Conditions" "Age Verification Modals" "AJAX Login Modals" "Advanced Theme Builder" "Aweber Integration" "BuddyPress Integration" "EDD" "Exit Intent" "Forced Interaction" "Geotargeting" "Leaving Notices" "MailChimp Integration" "Remote Content" "Scheduling" "Scroll Triggers" "Secure Idle User Logout" "Terms Conditions" "Videos" "WooCommerce Pro")

install_repo() {
    label=${label:-"extension"}
    repo=${repo}
    path=${path}

    # Map named parameters
    while [ $# -gt 0 ]; do
        if [[ $1 == *"--"* ]]; then
            param="${1/--/}"
            declare $param="$2"
            # echo $1 $2 // Optional to see the parameter:value result
        fi

        shift
    done

    repo_url="git@github.com:PopupMaker/$repo.git"

    # install_path is ./app/extensions/$repo if $repo is not equal to "Popup-Maker"
    [ "$repo" == "Popup-Maker" ] && install_path="$base_path/core/" || install_path="$base_path/extensions/$repo"

    if [[ ! -d "$install_path" ]]; then
        echo "⏳ Installing ${label}..."
        git clone -q "$repo_url" "$install_path"
        echo "✅ ${label} installed successfully."
    else
        git -C "${path}" fetch
        echo "✅ ${label} already installed, updated instead."
    fi

    symlink_path=${symlink_dir}/${path}

    if [ ! -d symlink_path ]; then
        echo "⏳ Symlinking ${label}..."
        ln -sfr "$install_path" "$symlink_path"
    fi
}

install_extension() {
    extension=${extension}

    # Map named parameters
    while [ $# -gt 0 ]; do
        if [[ $1 == *"--"* ]]; then
            param="${1/--/}"
            declare $param="$2"
            # echo $1 $2 // Optional to see the parameter:value result
        fi

        shift
    done

    case "$extension" in
    "Popup Analytics")
        install_repo --repo "Analytics" --path "popup-maker-popup-analytics" --label "$extension"
        ;;
    "Advanced Targeting Conditions")
        install_repo --repo "Advanced-Targeting-Conditions" --path "popup-maker-advanced-targeting-conditions" --label "$extension"
        ;;

    "Age Verification Modals")
        install_repo --repo "Age-Verification-Modals" --path "popup-maker-age-verification-modals" --label "$extension"
        ;;

    "AJAX Login Modals")
        install_repo --repo "AJAX-Login-Modals" --path "popup-maker-ajax-login-modals" --label "$extension"
        ;;

    "Advanced Theme Builder")
        install_repo --repo " Advanced-Theme-Builder" --path "popup-maker-advanced-theme-builder" --label "$extension"
        ;;
    "Aweber Integration")
        install_repo --repo "Aweber-Integration" --path "pum-aweber-integration" --label "$extension"
        ;;
    "BuddyPress Integration")
        install_repo --repo "BuddyPress-Integration" --path "popup-maker-buddyPress-integration" --label "$extension"
        ;;
    "EDD")
        install_repo --repo "EDD" --path "popup-maker-edd-pro" --label "EDD Pro"
        ;;
    "Exit Intent")
        install_repo --repo "Exit-Intent" --path "popup-maker-exit-intent" --label "$extension"
        ;;
    "Forced Interaction")
        install_repo --repo "Forced-Interaction" --path "popup-maker-forced-interaction" --label "$extension"
        ;;
    "Geotargeting")
        install_repo --repo "Geotargeting" --path "popup-maker-geotargeting" --label "$extension"
        ;;
    "Leaving Notices")
        install_repo --repo "Leaving-Notices" --path "popup-maker-leaving-notices" --label "$extension"
        ;;
    "MailChimp Integration")
        install_repo --repo "MailChimp-Integration" --path "popup-maker-mailChimp-integration" --label "$extension"
        ;;
    "Remote Content")
        install_repo --repo "Remote-Content" --path "popup-maker-remote-content" --label "$extension"
        ;;
    "Scheduling")
        install_repo --repo "Scheduling" --path "pum-scheduling" --label "$extension"
        ;;
    "Scroll Triggers")
        install_repo --repo "Scroll-Triggers" --path "popup-maker-scroll-triggered-popups" --label "$extension"
        ;;
    "Secure Idle User Logout")
        install_repo --repo "Secure-Idle-User-Logout" --path "popup-maker-secure-idle-user-logout" --label "$extension"
        ;;
    "Terms Conditions")
        install_repo --repo "Terms-Conditions" --path "popup-maker-terms-conditions-popups" --label "$extension"
        ;;
    "Videos")
        install_repo --repo "Videos" --path "pum-videos" --label "$extension"
        ;;
    "WooCommerce Pro")
        install_repo --repo "WooCommerce" --path "pum-woocommerce-pro" --label "WooCommerce Pro"
        ;;
    *)
        echo -n "unknown"
        ;;
    esac
}

menu() {
    refresh_screen
    echo "Choose extensions to install:"
    for i in ${!options[@]}; do
        printf "%02d) [%s] %s\n" $((i + 1)) "${extensions[i]:- }" "${options[i]}"
    done
    if [[ "$msg" ]]; then echo "$msg"; fi
}

prompt="Check an option (again to uncheck, ENTER when done): "
while menu && read -rsp "$prompt" -n 2 num && [[ "$num-1" ]]; do
    echo "${extensions[*]}"
    if [[ $num = "" ]]; then
        break
    else
        [[ "$num" != *[![:digit:]]* ]] &&
            ((num > 0 && num <= ${#options[@]})) ||
            {
                msg="Invalid option: $num"
                continue
            }
        [[ "${extensions[num - 1]}" ]] && extensions[num - 1]="" || extensions[num - 1]="x"
    fi
done

refresh_screen

# Clone core plugin.
install_repo --label "Popup Maker Core" --repo "Popup-Maker" --path "popup-maker"

# Install selected extensions.
for i in ${!options[@]}; do
    [[ "${extensions[i]}" ]] && { install_extension --extension "${options[i]}"; }
done
echo "$msg"
