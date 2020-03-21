#!/bin/sh

if ! command -v apt-get >/dev/null 2>&1
then
    exit 0
fi

echo "  Installing linux utilities"
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install wget curl tmux vim git
