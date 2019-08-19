#!/bin/bash
# Use this to compare what's currently installed with what's listed here:

A=/tmp/tempA.txt
B=/tmp/tempB.txt
echo "Installed" > $A
echo "---" >> $A
brew leaves | sort >> $A
echo "In Config" > $B
echo "---" >> $B
cat ~/.dotfiles/homebrew/install.sh | grep '^brew install' | cut -d' ' -f3 | sort >> $B
vimdiff /tmp/tempA.txt /tmp/tempB.txt
