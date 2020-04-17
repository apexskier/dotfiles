# python
if command -v python >/dev/null 2>&1; then
    mkdir -p $HOME/.virtualenvs
    export WORKON_HOME="$HOME/.virtualenvs"
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true
    export VIRTUALENVWRAPPER_VIRTUALENV="virtualenv"
    export PIP_DOWNLOAD_CACHE=$HOME/.pip/caches

    [ -f /usr/local/bin/virtualenvwrapper.sh ] && . /usr/local/bin/virtualenvwrapper.sh
    if [ -d ~/Library/Python/3.7/bin ]; then
        export PATH="$PATH:~/Library/Python/3.7/bin"
    fi
fi
