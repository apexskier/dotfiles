if ! command -v go >/dev/null 2>&1; then
    return 0
fi

function _chgo_env() {
    export GOROOT=$(cd $(dirname $(command -v go)); cd $(dirname $(dirname $(readlink $(command -v go)))); pwd)/libexec
    export GO_VERSION=$(go version | cut -d' ' -f3)

    # I should remove the old gopath from PATH, but that's a pain in the ass
    # and this isn't getting run much

    export GOPATH="$HOME/.$GO_VERSION"
    export PATH="$PATH:$GOPATH/bin"
}

function chgo() {
    local version
    if [ -n "$1" ]
    then
        version="@$1"
    fi
    brew unlink $(brew list | grep -E '^go(@|$)')
    brew link --overwrite --force "go$version"

    _chgo_env
}

_chgo_env
