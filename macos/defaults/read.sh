#!/usr/bin/env bash

# WIP
# this script extracts settings from domains
#
# using `plutil` for file modification reformats the file in some not ideal ways
# for version control (reorders keys, and strips comments)
# `xmllint` doesn't
# I see a lot fo stuff online about `xmlstarlet`, but it's not built-in

# set -x
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

function read_plist() {
    FILE=$1

    FILENAME=$(basename "$FILE")
    DOMAIN=${FILENAME%.*}

    echo "$DOMAIN"

    if [ "$DOMAIN" == "com.apple.terminal" ]
    then
        # terminal conf contains invalid xml in its themes
        echo "Skipping terminal"
        exit 0
    fi

    local TEMP_FILE
    TEMP_FILE=$(mktemp)

    defaults export "$DOMAIN" - > "$TEMP_FILE"

    COUNT=$(xmllint --xpath 'count(/plist/dict/*)' "$FILE")
    for I in $(seq 1 $((COUNT / 2)))
    do
        KEY=$(xmllint --xpath "string(/plist/dict/*[$(((I - 1) * 2 + 1))])" "$FILE")
        SAVED_VALUE_XPATH="/plist/dict/*[$(((I - 1) * 2 + 2))]"
        EXISTING_KEY_XPATH="/plist/dict/*[text()='$KEY']"
        EXISTING_VALUE_XPATH="$EXISTING_KEY_XPATH/following-sibling::*[1]"
        EXISTING_KEY_IN_WRITTEN=$(xmllint --nowarning --xpath "count($EXISTING_KEY_XPATH)" "$TEMP_FILE")
        if [ "$EXISTING_KEY_IN_WRITTEN" == 0 ]
        then
            echo "-> <key>$KEY</key> not found in $DOMAIN, please remove manually"
            continue
        fi

        WRITTEN_NODE_EMPTY=$(xmllint --nowarning --xpath "count(${EXISTING_VALUE_XPATH}[.=''])" "$TEMP_FILE")
        if [ "$WRITTEN_NODE_EMPTY" == 0 ]
        then
            WRITTEN_VALUE=$(xmllint --nowarning --xpath "$EXISTING_VALUE_XPATH" "$TEMP_FILE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr -d '\n')
            # if WRITTEN_VALUE is larger than 400 characters, we can't use xmllint's shell set for it
            if [ ${#WRITTEN_VALUE} -gt 400 ]
            then
                echo "-> <key>$KEY</key> value is too large to write with xmllint shell, please apply manually: $WRITTEN_VALUE"
                continue
            fi
            xmllint --noout --shell "$FILE" > /dev/null <<EOF
cd ${SAVED_VALUE_XPATH}
set ${WRITTEN_VALUE}
save
EOF
        else
            WRITTEN_VALUE=$(xmllint --xpath "name($EXISTING_VALUE_XPATH)" "$TEMP_FILE")
            SAVED_VALUE=$(xmllint --xpath "name($SAVED_VALUE_XPATH)" "$FILE")
            # TODO - I haven't figured out how to write this with xmllint
            # and I don't want to use plutil since it messes up the file
            if [ "$SAVED_VALUE" != "$WRITTEN_VALUE" ]
            then
                # plutil -extract "$KEY" xml1 -o - "$FILE"
                SAVED_XML=$(xmllint --xpath "/plist/node()" <(plutil -extract "$KEY" xml1 -o - "$FILE") | xargs)
                WRITTEN_XML=$(xmllint --xpath "/plist/node()" <(plutil -extract "$KEY" xml1 -o - "$TEMP_FILE") | xargs)

                echo "-> <key>$KEY</key> changed from $SAVED_XML to $WRITTEN_XML"
                echo "-> please apply this manually"
            fi
        fi
    done

    "$DIR/clean.sh" "$FILE"
}

if [ -n "$1" ]
then
    read_plist "$1"
else
    for FILE in "$DIR"/plists/*.plist
    do
        read_plist "$FILE"
    done
fi
