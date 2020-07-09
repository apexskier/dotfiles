if ! command -v python >/dev/null 2>&1; then
    return 0
fi

export PIP_DOWNLOAD_CACHE=$HOME/.pip/caches
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENVWRAPPER_VIRTUALENV="virtualenv"
export WORKON_HOME="$HOME/.virtualenvs"

mkdir -p "$WORKON_HOME"

[ -f /usr/local/bin/virtualenvwrapper.sh ] && . /usr/local/bin/virtualenvwrapper.sh

if [ -d ~/Library/Python/3.7/bin ]; then
    export PATH="$PATH:~/Library/Python/3.7/bin"
fi
