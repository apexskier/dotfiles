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

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
  fi

fi

if command -v brew >/dev/null 2>&1
then
    HOMEBREW_CASK_OPTS="--appdir=/Applications"
    echo "  Installing command line tools"
    bash `git rev-parse --show-cdup`homebrew/Brewfile
    # echo "  Installing apps"
    # bash `git rev-parse --show-cdup`homebrew/Caskfile

    echo "    you may want to install xQuartz -> http://xquartz.macosforge.org/landing/"
fi

exit 0
