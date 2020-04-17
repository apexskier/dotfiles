#!bash
# vim: ft=sh

if shopt -oq posix; then
    # non-interactive shell
    exit 0
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f /usr/local/etc/profile.d/bash_completion.sh ] && . /usr/local/etc/profile.d/bash_completion.sh

# not sure why this doesn't work
# if [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
# fi
