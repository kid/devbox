#!/bin/bash

set -e

# Install haveged to ensure we have enough entropy
sudo pacman -S --noconfirm --needed haveged git tig
sudo systemctl enable haveged
sudo systemctl start haveged

sudo pacman-key --keyserver hkp://keyserver.kjsl.com:80 --refresh-keys

git config --global url.https://github.com/.insteadOf git://github.com/

# First update system

sudo pacman -Suy --noconfirm

# Install pacaur

sudo pacman -S --needed --noconfirm base-devel curl

gpg --keyserver hkp://keyserver.kjsl.com:80 --recv-keys 487EACC08557AD082088DABA1EB2638FF56C0C53

buildroot="$(mktemp -d)"

mkdir -p "${buildroot}/cower" "${buildroot}/pacaur"

cd "${buildroot}/cower" || exit 1
curl -L https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower > PKGBUILD
makepkg --syncdeps --install --noconfirm

cd "${buildroot}/pacaur" || exit 1
curl -L https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur > PKGBUILD
makepkg --syncdeps --install --noconfirm

rm -rf "${buildroot}"

# Install everything else

pacaur -S --noconfirm --needed --noedit \
  xorg-server \
  xorg-server-utils \
  xorg-apps \
  xorg-xinit \
  xterm \
  powerline-fonts-git \
  i3 \
  dmenu \
  fish \
  tmux \
  python \
  python-pip

grep -q "^EDITOR=vim" /etc/environment || echo "EDITOR=vim" | sudo tee --append /etc/environment
grep -q "^VISUAL=vim" /etc/environment || echo "VISUAL=vim" | sudo tee --append /etc/environment

# Install nvm
cd /home/vagrant && git clone https://github.com/creationix/nvm.git .nvm && cd .nvm && git checkout `git describe --abbrev=0 --tags`

# Install fisherman and some plugins
cd /home/vagrant && git clone https://github.com/fisherman/fisherman .fisherman && cd .fisherman && make
fish -c "fisher install bobthefish bass"

# https://github.com/tagae/dotfiles/blob/master/xinitrc.d/10-resources.sh
