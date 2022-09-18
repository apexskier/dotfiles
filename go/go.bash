function _chgo_env() {
    GO_BIN_PATH=$(command -v go 2>/dev/null)
    GO_BIN_AVAILABLE=$?
    if [ $GO_BIN_AVAILABLE -ne 0 ]; then
        return 1
    fi

    GOROOT=$(cd "$(dirname "$GO_BIN_PATH")" || return; cd "$(dirname "$(dirname "$(readlink "$GO_BIN_PATH")")")" || return; pwd)/libexec
    GO_VERSION=$(go version | cut -d' ' -f3)
    export GOROOT
    export GO_VERSION

    # I should remove the old gopath from PATH, but that's a pain in the ass
    # and this isn't getting run much

    export GOPATH="$HOME/.$GO_VERSION"
    export PATH="$PATH:$GOPATH/bin"
}

function chgo() {
    local version
    local gomodfile

    if [ -n "$1" ]
    then
        version="@$1"
    elif gomodfile=$(file_in_tree go.mod)
    then
        version="$(grep '^go ' "$gomodfile")"
        version="@${version:3}"
    fi

    INSTALLED_GOS=$(brew list | grep -E '^go(@|$)')
    brew unlink ${INSTALLED_GOS[@]}
    brew link --overwrite --force "go$version"

    _chgo_env
}

_chgo_env
