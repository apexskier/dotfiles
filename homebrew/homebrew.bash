if command -v brew >/dev/null 2>&1; then
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    bp=$(brew --prefix)
    [ -f "$bp/git/contrib/completion/git-completion.bash" ] && . "$bp/git/contrib/completion/git-completion.bash"
    [ -f "$bp/etc/bash_completion" ] && . "$bp/etc/bash_completion"

    export PATH="$PATH:$bp/opt/curl/bin"
fi
