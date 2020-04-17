export PATH="$PATH:./node_modules/.bin"
export PATH="$HOME/.yarn/bin:$PATH"
export REACT_DEBUGGER="open -g 'rndebugger://set-debugger-loc?port=8001'"
export REACT_EDITOR_CMD=code
export REACT_EDITOR_PATTERN="-r -g {filename}:{line}:{column}"

function chnode() {
    local version
    if [ -n "$1" ]
    then
        version="@$1"
    fi
    brew unlink $(brew list | grep node)
    brew link --overwrite --force "node$version"
}
