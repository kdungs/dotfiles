#!/bin/zsh

ZSH_PLUGINS_DIR="${HOME}/.zsh-plugins"

set -e

mkdir -p "${ZSH_PLUGINS_DIR}"
pushd "${ZSH_PLUGINS_DIR}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting
popd
