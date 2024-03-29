#!/usr/bin/env bash
#
# bootstrap installs things.

gitconfig_local_file="$HOME/.gitconfig.local"

touch "$gitconfig_local_file"

git_credential='cache'
if [ "$(uname -s)" == "Darwin" ]
then
    git_credential='osxkeychain'
fi
git config --file "$gitconfig_local_file" credential.helper "$git_credential"

if [ -z "$(git config user.name)" ]
then
    echo 'What is your github author name?'
    read -re git_authorname
    git config --file "$gitconfig_local_file" user.name "$git_authorname"
fi

if [ -z "$(git config user.email)" ]
then
    echo 'What is your github author email?'
    read -re git_authoremail
    git config --file "$gitconfig_local_file" user.email "$git_authoremail"
fi
