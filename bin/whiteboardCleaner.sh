#!/bin/bash
FULLNAME=$1
EXT="${FULLNAME##*.}"
NAME="${FULLNAME%.*}"
CLEANNAME=${NAME}-clean.${EXT}

convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "${CLEANNAME}"
# tesseract "${CLEANNAME}" "${NAME}" 2> /dev/null
