#!/usr/bin/env bash

set -e

parent_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
dotfiles_dir="$(cd "$(dirname "$parent_dir")" && pwd -P)"

source "$dotfiles_dir/script/output.sh"

if ! command -v docker >/dev/null 2>&1
then
    exit 0
fi

if ! docker info > /dev/null 2>&1
then
    info "docker is not running, skipping docker install"
    exit 0
fi

# this doesn't install docker, but pulls my docker toolbox image in

docker pull ghcr.io/apexskier/dotfiles/toolbox:latest
docker tag ghcr.io/apexskier/dotfiles/toolbox:latest toolbox
