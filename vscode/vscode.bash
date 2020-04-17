# see https://github.com/microsoft/vscode/issues/60579 for why I don't use the built in binary
# this is also faster

code() {
    if [ -t 1 ] && [ -t 0 ]; then
        open -a "Visual Studio Code.app" "$@"
    else
        open -a "Visual Studio Code.app" -f
    fi
}
