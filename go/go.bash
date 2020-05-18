if command -v go >/dev/null 2>&1; then
    export GOROOT=$(cd $(dirname $(command -v go)); cd $(dirname $(dirname $(readlink $(command -v go)))); pwd)/libexec
    export GOPATH="$HOME/.go"
    export PATH="$PATH:$GOPATH/bin"

    if test -L $(command -v go); then
        function chgo() {
            local version
            if [ -n "$1" ]
            then
                version="@$1"
            fi
            brew unlink $(brew list | grep '^go')
            brew link --overwrite --force "go$version"

            export GOROOT=$(cd $(dirname $(command -v go)); cd $(dirname $(dirname $(readlink $(command -v go)))); pwd)/libexec
        }
    fi
fi
