#!/usr/bin/env bash

set -e

if ! command -v docker >/dev/null 2>&1
then
    exit 0
fi

# this doesn't install docker, but pulls my docker toolbox image in

docker pull ghcr.io/apexskier/dotfiles/toolbox:latest
docker tag ghcr.io/apexskier/dotfiles/toolbox:latest toolbox
