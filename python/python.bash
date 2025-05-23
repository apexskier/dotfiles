export PIP_DOWNLOAD_CACHE=$HOME/.pip/caches
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export VIRTUALENVWRAPPER_VIRTUALENV="virtualenv"
export WORKON_HOME="$HOME/.virtualenvs"
export PROJECT_HOME="$HOME/Developer"
export VIRTUALENVWRAPPER_PYTHON=/opt/homebrew/bin/python3

mkdir -p "$WORKON_HOME"

[ -f /usr/local/bin/virtualenvwrapper.sh ] && . /usr/local/bin/virtualenvwrapper.sh
[ -f /opt/homebrew/bin/virtualenvwrapper.sh ] && . /opt/homebrew/bin/virtualenvwrapper.sh
[ -d /opt/homebrew/anaconda3/bin/ ] && export PATH="/opt/homebrew/anaconda3/bin:$PATH"

