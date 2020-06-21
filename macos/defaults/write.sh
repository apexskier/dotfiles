#!/usr/bin/env bash

# this script converts a plist file into macOS defaults commands
# The name of the file (without the extension) is the domain used

# set -x
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

function write_plist() {
    local FILE=$1

    local FILENAME=$(basename "$FILE")
    local DOMAIN=${FILENAME%.*}

    local REOPEN=""

    echo $DOMAIN

    # kill applications before writing defaults
    # (recommended in defaults manpage)
    # and reopen them once done
    if [ "$DOMAIN" != "com.app.terminal" ]
    then
        # This can have multiple results (e.g. if I have an app I'm working on in XCode and installed from the app)
        # since pkill can't tell which one was running, I'm just going to reopen
        # the first
        APP_PATH=$(mdfind kMDItemCFBundleIdentifier = "$DOMAIN" | head -n 1)
        if [ -n "$APP_PATH" ]
        then
            APP_NAME_DOTAPP=$(basename "$APP_PATH")
            APP_NAME=${APP_NAME_DOTAPP%.*}
            if pkill -x "$APP_NAME"
            then
                REOPEN="$APP_PATH"
            fi
        fi
    elif [ "$DOMAIN" == "NSGlobalDomain" ]
    then
        osascript -e 'tell application "System Preferences" to quit'
    fi

    COUNT=$(xmllint --xpath 'count(/plist/dict/*)' "$FILE")
    for I in $(seq 1 $((COUNT / 2)))
    do
        KEY=$(xmllint --xpath "string(/plist/dict/*[$((($I - 1) * 2 + 1))])" "$FILE")
        VALUE=$(xmllint --xpath "/plist/dict/*[$((($I - 1) * 2 + 2))]" "$FILE")

        (set -f; IFS=$'\n'; exec defaults write "$DOMAIN" "$KEY" "$VALUE")
    done

    if [ -n "$REOPEN" ]
    then
        open -g "$REOPEN"
    fi
}

if [ -n "$1" ]
then
    write_plist $1
else
    for FILE in $(ls "$DIR/plists/"*.plist)
    do
        write_plist $FILE
    done
fi
