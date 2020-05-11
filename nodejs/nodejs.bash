export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:$HOME/.yarn/bin"
export REACT_DEBUGGER="open -g 'rndebugger://set-debugger-loc?port=8001'"
export REACT_EDITOR_CMD=code
export REACT_EDITOR_PATTERN="-r -g {filename}:{line}:{column}"

function chnode() {
    if [ "$(uname -s)" != "Darwin" ]; then
        echo "macos only"
        return 1
    fi

    PATH_PREFIX="$(brew --prefix)/Cellar/node"

    # clear prior path
    # https://stackoverflow.com/a/370192/2178159
    export PATH=$(echo "$PATH" | awk -v RS=: -v ORS=: "/${PATH_PREFIX//\//\\/}/ {next} {print}" | sed 's/:*$//')

    if [ -n "$1" ]
    then
        local NODE_PATH=$(eval echo "$PATH_PREFIX*/$1*/bin/")
        if [ -d "$NODE_PATH" ]
        then
            echo "using node $(echo "$NODE_PATH" | rev | cut -d'/' -f3 | rev)"
            export PATH="$NODE_PATH:$PATH"
        else
            echo "no node installation found for '$1'"
            return 1
        fi
    else
        echo "using system installation"
    fi
}
