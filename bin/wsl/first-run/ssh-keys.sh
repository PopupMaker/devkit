#!/bin/bash

# Setup git config.
echo \# Set up SSH
echo 1. Create SSH keys on Windows. https://phoenixnap.com/kb/generate-ssh-key-windows-10
echo 2. Enter the path to your .ssh folder.
echo ""
read -p "Windows SSH path in WSL [/mnt/c/Users/<username>/.ssh]: " ssh_path
name=${ssh_path}

cp -r $name ~

chmod 600 ~/.ssh/*

echo SSH keys cloned.
