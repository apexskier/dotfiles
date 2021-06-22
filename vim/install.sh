#!/usr/bin/env bash

# install plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install plugins now, instead of the first time vim opens
# echoing silences a warning from vim
echo "" | vim +PlugInstall +qall -
