#!/bin/bash

set -e

sudo pacman -S --noconfirm haveged git tig
sudo systemctl enable haveged
sudo systemctl start haveged

sudo pacman-key --keyserver hkp://keyserver.kjsl.com:80 --refresh-keys

git config --global url.https://github.com/.insteadOf git://github.com/

pacaur -Suy
pacaur -S --noconfirm --noedit \
  xorg-server \
  xorg-server-utils \
  xorg-apps \
  xorg-xinit \
  xterm \
  powerline-fonts-git \
  i3 \
  dmenu2 \
  tmux

echo "EDITOR=vim" | sudo tee --append /etc/environment

# https://github.com/tagae/dotfiles/blob/master/xinitrc.d/10-resources.sh
