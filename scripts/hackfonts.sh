#!/bin/zsh

FONTDIR="~/.local/share/fonts"
HACKPATH="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack"

set -e

mkdir -p "${FONTDIR}"
pushd "${FONTDIR}"
curl -fLo "Hack Bold Nerd Font.ttf" "${HACKPATH}/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf"
curl -fLo "Hack BoldItalic Nerd Font.ttf" "${HACKPATH}/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete.ttf"
curl -fLo "Hack Italic Nerd Font.ttf" "${HACKPATH}/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete.ttf"
curl -fLo "Hack Regular Nerd Font.ttf" "${HACKPATH}/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf"
fc-cache -vf
popd
