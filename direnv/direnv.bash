if ! command -v direnv &>/dev/null; then
    return 0
fi

direnv version > /dev/null && eval "$(direnv hook bash)"
