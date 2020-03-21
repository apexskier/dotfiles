# this is a minimal debian image pre-loaded with my dotfiles intended for usage
# when debugging docker/kubernetes environments

FROM debian:stable-slim

WORKDIR /root
RUN mkdir .ssh
COPY . .dotfiles

WORKDIR /root/.dotfiles
RUN ./script/install
RUN DOTFILES_OVERWRITE=true DOTFILES_SKIP_GIT=true ./script/bootstrap
RUN apt-get clean

WORKDIR /root
CMD ["/bin/bash"]
