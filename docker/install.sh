#!/bin/sh

if ! command -v docker >/dev/null 2>&1
then
    exit 0
fi

# this doesn't install docker, but pulls our bash docker image in

