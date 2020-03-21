#!/bin/sh

if ! command -v apt-get >/dev/null 2>&1
then
    exit 0
fi

echo "  Installing linux utilities"
apt-get update
apt-get install -y \
    bash-completion \
    curl \
    dnsutils \
    fzf \
    git \
    jq \
    ripgrep \
    tmux \
    vim \
    wget \
    ""
# dnsutils contains dig
