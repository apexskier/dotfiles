if command -v go >/dev/null 2>&1; then
    export GOPATH="$HOME/.go"
    export PATH="$PATH:$GOPATH/bin"

    function chgo() {
        local version
        if [ -n "$1" ]
        then
            version="@$1"
        fi
        brew unlink $(brew list | grep '^go')
        brew link --overwrite --force "go$version"
    }
fi
