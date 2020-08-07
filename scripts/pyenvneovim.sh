#!/bin/zsh

set -e

NVIM_PY2_VERSION=2.7.18
NVIM_PY3_VERSION=3.8.2

pyenv install "${NVIM_PY2_VERSION}"
pyenv install "${NVIM_PY3_VERSION}"
pyenv virtualenv "${NVIM_PY2_VERSION}" py2neovim
pyenv virtualenv "${NVIM_PY3_VERSION}" py3neovim
pyenv activate py2neovim
pip install neovim
pyenv deactivate
pyenv activate py3neovim
pip install neovim
pyenv deactivate
