#!/bin/sh

# if you don't have sudo --> https://gist.github.com/isaacs/579814

if [ "$(uname -s)" != "Darwin" ] # use homebrew on mac
then
    # TODO:
    echo "  You should figure out how to install node and npm."
fi
