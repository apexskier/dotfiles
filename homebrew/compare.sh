#!/usr/bin/env bash
# Use this to compare what's currently installed with what's listed here:

A=$(mktemp)
B=$(mktemp)
echo "Installed" > $A
echo "---" >> $A
brew leaves | sort >> $A
echo "In Config" > $B
echo "---" >> $B
cat ~/.dotfiles/homebrew/install.sh | grep '^brew install' | cut -d' ' -f3 | sort >> $B
vimdiff "$A" "$B"
