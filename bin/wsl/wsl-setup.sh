#!/bin/sh
cd ~

# Update apt and install updates and needed packages.
sudo -s -- <<EOF
apt update
apt upgrade -y
apt dist-upgrade -y
apt autoremove -y
apt autoclean -y
apt install php-cli php-xmlwriter php-mbstring unzip curl wget ca-certificates -y
EOF

# Install NVM and latest stable NODE/npm.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Immediately export for use in CLI.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Install Node.
nvm install node --lts

# Get Composer Installer
EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
    echo >&2 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

# Install Composer Globally.
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RESULT=$?
rm composer-setup.php
echo $RESULT

# Install PHP & Composer dev dependencies globally.
composer global require squizlabs/php_codesniffer
composer global require dealerdirect/phpcodesniffer-composer-installer
composer global require wp-coding-standards/wpcs
composer global require phpcompatibility/phpcompatibility-wp:*

# Export the global compsoer bin to PATH via ~/.bashrc
echo 'export PATH=$PATH:$HOME/.config/composer/vendor/bin' >>~/.bashrc

# Install VS Code Server
code -v

echo 'alias python=python3' >>~/.bashrc
echo 'alias pip=pip3' >>~/.bashrc
