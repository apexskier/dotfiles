#!/bin/bash

# if you don't have sudo --> https://gist.github.com/isaacs/579814

if [ "$(uname -s)" == "Darwin" ] # use homebrew on mac
then
    echo '  installing node'
    curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh >/dev/null 2>/dev/null | bash >/dev/null 2>/dev/null
    test -O ~/.nvm || sudo chown -R $USER ~/.nvm
    source ~/.nvm/nvm.sh >/dev/null
    nvm install 0.10 >/dev/null # replace with stable
    nvm alias default 0.10 >/dev/null # replace with stable
else
    # TODO:
    echo "  You should figure out how to install node and npm."
fi
