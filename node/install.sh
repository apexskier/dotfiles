#!/bin/bash

echo '  installing node'
curl https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh >/dev/null 2>/dev/null | bash >/dev/null 2>/dev/null
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi
nvm install node >/dev/null
nvm alias default node >/dev/null
