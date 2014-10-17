#!/bin/sh

if hash apt-get
then
    echo "  Installing linux utilities"
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install wget curl tmux vim git awesome easy_install
fi
