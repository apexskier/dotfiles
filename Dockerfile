# this is a minimal debian image pre-loaded with my dotfiles intended for usage
# when debugging docker/kubernetes environments

FROM debian:stable-slim

RUN apt-get update
RUN apt-get install -y curl
# dnsutils contains dig
RUN apt-get install -y dnsutils
RUN apt-get install -y fzf
RUN apt-get install -y git
RUN apt-get install -y jq
RUN apt-get install -y ripgrep
RUN apt-get install -y tmux
RUN apt-get install -y vim
RUN apt-get clean

WORKDIR /root
RUN mkdir .ssh
COPY . .dotfiles

WORKDIR /root/.dotfiles
RUN DOTFILES_OVERWRITE=true DOTFILES_SKIP_GIT=true ./script/bootstrap
RUN ./vim/install.sh

WORKDIR /root
CMD ["/bin/bash"]
