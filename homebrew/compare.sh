#!/usr/bin/env bash
#
# Use this to compare what's currently installed with what's in the dotfiles
#
# I have a bunch of stuff installed on my work computer that I don't actually
# want in my dotfiles, so I don't want to just dump directly

# TODO: try to figure out how to use `brew leaves`

vimdiff <(brew bundle --describe dump --file=-) ~/.dotfiles/homebrew/Brewfile
