#!/usr/bin/env bash

# WIP
# this script extracts settings from domains

# set -x
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

function read_plist() {
    FILE=$1

    FILENAME=$(basename "$FILE")
    DOMAIN=${FILENAME%.*}

    echo $DOMAIN

    if [ $DOMAIN == "com.apple.terminal" ]
    then
        # terminal conf contains invalid xml in it's themes
        echo "Skipping terminal"
        exit 0
    fi

    local TEMP_FILE=$(mktemp)

    defaults export "$DOMAIN" - > $TEMP_FILE

    COUNT=$(xmllint --xpath 'count(/plist/dict/*)' "$FILE")
    for I in $(seq 1 $((COUNT / 2)))
    do
        KEY=$(xmllint --xpath "string(/plist/dict/*[$((($I - 1) * 2 + 1))])" "$FILE")
        VALUE_XPATH="/plist/dict/*[$((($I - 1) * 2 + 2))]"
        # this happens for booleans - WRITTEN_TYPE will be true or false
        WRITTEN_NODE_EMPTY=$(xmllint --nowarning --xpath "count(/plist/dict/*[text()='$KEY']/following-sibling::*[1][.=''])" "$TEMP_FILE")
        if [ "$WRITTEN_NODE_EMPTY" == 0 ]
        then
            WRITTEN_VALUE=$(xmllint --nowarning --xpath "/plist/dict/*[text()='$KEY']/following-sibling::*[1]/node()" "$TEMP_FILE" | tr -d '\n')
            # note: I don't think the set value here can have newlines
            # (can't have literals - they'll be individual commands, can't have
            # be escaped like \n, can't be quoted)
            # if they could, clean.sh and xmllint -format wouldn't be necessary
            xmllint --noout --shell "$FILE" > /dev/null <<EOF
cd ${VALUE_XPATH}
set ${WRITTEN_VALUE}
save
EOF
        else
            WRITTEN_VALUE=$(xmllint --xpath "name(/plist/dict/*[text()='$KEY']/following-sibling::*[1])" "$TEMP_FILE")
            SAVED_VALUE=$(xmllint --xpath "name($VALUE_XPATH)" "$FILE")
            # TODO - I haven't figured out how to write this with xmllint
            if [ "$SAVED_VALUE" != "$WRITTEN_VALUE" ]
            then
                echo "-> \"$KEY\" changed from $SAVED_VALUE to $WRITTEN_VALUE"
                echo "-> please apply this manually"
            fi
        fi
    done

    "$DIR/clean.sh" $FILE
}

if [ -n "$1" ]
then
    read_plist $1
else
    for FILE in $(ls "$DIR/plists/"*.plist)
    do
        read_plist $FILE
    done
fi
