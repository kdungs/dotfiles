#!/bin/zsh

set -e

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm \
  alacritty \
  firefox \
  git \
  htop \
  i3-wm \
  i3lock \
  i3status \
  lightdm \
  lightdm-gtk-greeter \
  neovim \
  noto-fonts{,-cjk,-emoji,-extra} \
  stow \
  tmux \
  xorg-server

pushd ..
stow \
  alacritty \
  git \
  i3 \
  neovim \
  tmux \
  zsh
popd

./hackfonts.sh
./pyenv.sh
./pyenvneovim.sh
./vimplug.sh
./zshsyntax.sh

# Configure lightdm for i3
# Needs manual intervention.
sudo nvim /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm

