#!/bin/sh

set -e

if ! command -v docker >/dev/null 2>&1
then
    exit 0
fi

# this doesn't install docker, but pulls our bash docker image in

cat ~/.GITHUB_TOKEN | docker login docker.pkg.github.com -u apexskier --password-stdin
docker pull docker.pkg.github.com/apexskier/dotfiles/toolbox:latest
docker tag docker.pkg.github.com/apexskier/dotfiles/toolbox:latest toolbox
