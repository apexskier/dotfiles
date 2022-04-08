#!/usr/bin/env bash

if ! command -v brew >/dev/null 2>&1; then
    exit 0
fi

"$(brew --prefix)"/opt/fzf/install
