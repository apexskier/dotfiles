#!/bin/bash

set -e

CURRENT_BG_ID=3FC050C5-95EE-4CA8-907C-FDACF119AA1F
ZOOM_PATH=/Users/cameron/Library/Application\ Support/zoom.us/data/VirtualBkgnd_Custom
BG_PATH=/Users/cameron/Pictures/Zoom\ Backgrounds
BG_FILE=$(find "$BG_PATH" -type f | sort -R | head -1)

echo $1
if [ -n "$1" ]; then
    echo "Found $1"
    if ! [ -f "$1" ]; then
        echo "$1 is not a file"
        exit 1
    fi
    BG_FILE=$1
fi


# Only replace the file when Zoom isn't running
if ! pgrep -x zoom.us; then
    echo "Setting zoom background to $BG_FILE"
    cp "$BG_FILE" "$ZOOM_PATH/$CURRENT_BG_ID"
fi
