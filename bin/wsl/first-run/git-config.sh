#!/bin/bash

# Setup git config.
echo \# Setting Up Git
echo Enter your git commit details:

read -p '- User Name: ' git_user_name
read -p '- Email: ' git_user_email

git config --global user.name "$git_user_name"
git config --global user.email "$git_user_email"

echo Git config saved.
