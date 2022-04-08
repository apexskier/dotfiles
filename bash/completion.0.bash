#!/bin/bash
# vim: ft=sh

if shopt -oq posix; then
    # non-interactive shell
    return 0
fi

[ -f /usr/local/etc/profile.d/bash_completion.sh ] && . /usr/local/etc/profile.d/bash_completion.sh
