#!/usr/bin/env bash

# install plugin manager
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install plugins now, instead of the first time vim opens
# reading from stdin allows this to be run from another script
echo "" | vim -c ':PlugInstall --sync | :qa' -
