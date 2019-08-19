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
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
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

brew install bash-completion
brew install git
brew install hub
brew install imagemagick
brew install jq
brew install fzf
brew install rg
brew install node # and `npm`
brew install tmux

# I'm not sure about all this stuff yet

# # Install GNU core utilities (those that come with OS X are outdated)
# # Don't forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
# brew install coreutils
# # Install some other useful utilities like `sponge`
# brew install moreutils
# # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
# brew install findutils
# # Install Bash 4
# # Note: don't forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
# brew install bash
# brew install bash-completion
brew install gnu-sed

# # Install wget with IRI support
# brew install wget --enable-iri

# # Install more recent versions of some OS X tools
brew install vim
# brew install homebrew/dupes/grep

# brew install ack

# Remove outdated versions from the cellar
brew cleanup
