if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v brew >/dev/null 2>&1; then
    return 0
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

bp=$(brew --prefix)
[ -f "$bp/git/contrib/completion/git-completion.bash" ] && . "$bp/git/contrib/completion/git-completion.bash"
[ -f "$bp/etc/bash_completion" ] && . "$bp/etc/bash_completion"
[ -f "$bp/etc/profile.d/bash_completion.sh" ] && . "$bp/etc/profile.d/bash_completion.sh"

export PATH="$PATH:$bp/opt/curl/bin"
