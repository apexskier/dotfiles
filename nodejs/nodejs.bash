export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:$HOME/.yarn/bin"
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
