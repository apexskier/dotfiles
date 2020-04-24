if command -v go >/dev/null 2>&1; then
    if [ -d "/usr/local/go/" ]; then
        export GOROOT=/usr/local/go
    fi
    export PATH="$PATH:$GOROOT/bin"

    export GOPATH="$HOME/.go"
    export PATH="$PATH:$GOPATH/bin"
fi
