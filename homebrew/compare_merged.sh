#!/usr/bin/env bash
#

vimdiff <(brew bundle --describe dump --file=- | grep -v "^#" | sort) <(cat ~/.dotfiles/homebrew/Brewfile* | grep -v "^#" | sort | uniq)
