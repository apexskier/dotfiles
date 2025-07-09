#!/usr/bin/env bash

# WIP
# this script extracts settings from domains

# set -x
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

function clean_plist() {
    local FILE=$1
    local TEMP_FILE
    TEMP_FILE=$(mktemp)

    xmllint -format "$FILE" > "$TEMP_FILE"
    cat "$TEMP_FILE" > "$FILE"
}

if [ -n "$1" ]
then
    clean_plist "$1"
else
    for FILE in "$DIR/plists/"*.plist
    do
        clean_plist "$FILE"
    done
fi
