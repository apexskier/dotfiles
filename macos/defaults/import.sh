#!/usr/bin/env bash

# usage
# ./import.sh com.apple.Safari
# ./import.sh /Applications/Safari.app

set -e
# set -x

if [ -d "$1" ]
then
    DOMAIN=$(mdls -name kMDItemCFBundleIdentifier -r "$1")
else
    DOMAIN=$1
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
FILE="$DIR/plists/$DOMAIN.plist"

defaults export "$DOMAIN" - > "$FILE"

# remove all NS* keys - they're generally macOS global things that
# shouldn't be saved
while [ "$(xmllint --xpath "count(/plist/dict/*[starts-with(text(), 'NS')])" "$FILE")" != "0" ]
do
    KEY=$(xmllint --xpath "/plist/dict/*[starts-with(text(), 'NS')][1]/text()" "$FILE")
    if [ -z "$KEY" ]
    then
        break
    fi
    # escape periods
    KEY="${KEY//./\\.}"
    plutil -remove "$KEY" "$FILE"
done

"$DIR/clean.sh" "$FILE"
