#!/usr/bin/env bash

# this script converts a plist file into macOS defaults commands
# The name of the file (without the extension) is the domain used

# set -x
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

function write_plist() {
    FILE=$1

    FILENAME=$(basename "$FILE")
    DOMAIN=${FILENAME%.*}

    echo $DOMAIN

    COUNT=$(xmllint --xpath 'count(/plist/dict/*)' "$FILE")

    for I in $(seq 1 $((COUNT / 2)))
    do
        KEY=$(xmllint --xpath "string(/plist/dict/*[$((($I - 1) * 2 + 1))])" $FILE)
        VALUE_XPATH="/plist/dict/*[$((($I - 1) * 2 + 2))]"
        TYPE=$(xmllint --xpath "name($VALUE_XPATH)" $FILE)

        function process_value() {
            local VALUE_XPATH=$1
            local TYPE=$(xmllint --xpath "name($VALUE_XPATH)" $FILE)
            case "$TYPE" in
                integer)
                    VALUE=$(xmllint --xpath "string($VALUE_XPATH)" $FILE)
                    echo "-int"
                    echo "$VALUE"
                    ;;
                float)
                    VALUE=$(xmllint --xpath "string($VALUE_XPATH)" $FILE)
                    echo "-float"
                    echo "$VALUE"
                    ;;
                string)
                    EVAL=$(xmllint --xpath "string($VALUE_XPATH/@eval)" $FILE)
                    VALUE=$(xmllint --xpath "string($VALUE_XPATH)" $FILE)
                    echo "-string"

                    if [ "$EVAL" == "true" ]
                    then
                        # NOTE: This allows string values to contain env variables
                        # not secure for untrusted input
                        echo $(eval echo "$VALUE")
                    else
                        echo "$VALUE"
                    fi
                    ;;
                true|false)
                    echo "-bool"
                    echo "$TYPE"
                    ;;
                array)
                    echo "-array"
                    EL_COUNT=$(xmllint --xpath "count($VALUE_XPATH/*)" $FILE)
                    if [ "$EL_COUNT" == "0" ]
                    then
                        return
                    fi
                    for J in $(seq 1 $EL_COUNT)
                    do
                        process_value "$VALUE_XPATH/*[$J]" || return 1
                    done
                    ;;
                dict)
                    echo "-dict-add"
                    EL_COUNT=$(xmllint --xpath "count($VALUE_XPATH/*)" $FILE)
                    for J in $(seq 1 $((EL_COUNT / 2)))
                    do
                        KEY=$(xmllint --xpath "string($VALUE_XPATH/*[$((($J - 1) * 2 + 1))])" $FILE)
                        DICT_VALUE_XPATH="$VALUE_XPATH/*[$((($J - 1) * 2 + 2))]"
                        echo "$KEY"
                        process_value "$DICT_VALUE_XPATH" || return 1
                    done
                    ;;
                *)
                    >&2 echo "Unknown type \"$TYPE\" for key \"$KEY\""
                    return 1
            esac
        }

        (set -f; IFS=$'\n'; exec defaults write "$DOMAIN" "$KEY" $(process_value $VALUE_XPATH))
    done
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
