#!/bin/bash

git config --global user.name "molisiye"

current_email=$(git config --global --get user.email)

# if current_email is empty, then add en email
if [[ -z "$current_email" ]]; then
    git config --global user.email "molisiye@live.com"
fi

git config --global github.user molisiye
