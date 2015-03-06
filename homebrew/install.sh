#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if ! command -v brew >/dev/null 2>&1
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if command -v brew >/dev/null 2>&1
then
    HOMEBREW_CASK_OPTS="--appdir=/Applications"
    echo "  Installing command line tools"
    bash `git rev-parse --show-cdup`homebrew/Brewfile
    echo "  Installing apps"
    bash `git rev-parse --show-cdup`homebrew/Caskfile

    echo "    you may want to install xQuartz -> http://xquartz.macosforge.org/landing/"
fi

exit 0
