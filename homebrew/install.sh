#!/usr/bin/env bash
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

brew install bash-completion
brew install curl
brew install fzf
brew install git
brew install gnu-sed
brew install hub
brew install imagemagick
brew install jq
brew install kubernetes-cli
brew install macvim
brew install node # and `npm`, most recent versions
brew install node@10
brew install node@12
brew install ripgrep
brew install spaceman-diff
brew install terminal-notifier
brew install tmux
brew install vim
brew install watchman
brew install yarn

# Remove outdated versions from the cellar
brew cleanup
