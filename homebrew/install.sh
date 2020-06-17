#!/usr/bin/env bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

set -e

# Check for Homebrew
if ! command -v brew >/dev/null 2>&1
then
  echo "  Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  # elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  # then
  #   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  else
    echo "Homebrew not available on this system"
    exit 0
  fi
else
  # Make sure we're using the latest Homebrew
  brew update
fi

# Upgrade any already-installed formulae
brew upgrade

brew bundle install --no-lock --file ~/.dotfiles/homebrew/Brewfile

# Remove outdated versions from the cellar
brew cleanup
