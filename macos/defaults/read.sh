#!/usr/bin/env bash

# WIP
# this script extracts settings from domains

# set -x
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

    # diff <(defaults export $DOMAIN -) $FILE

    # cat $FILE | defaults import $DOMAIN -
