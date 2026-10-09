#!/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"
## check dependencies
os=$(uname -s)

## powerline-status on pipx
if [ -z $(command -v powerline) ]; then
    pipx install powerline-status
    pipx inject powerline-status pip
    pipx runpip powerline-status install pygit2 psutil
    cd widgets && ./install.sh && cd -
else
    echo "powerline server is already installed"
fi

## install bindings
POWERLINE_ROOT=$(pipx runpip powerline-status show powerline-status | grep Location | cut -d: -f2 | tr -d ' ')
safe_link ${POWERLINE_ROOT}/powerline/bindings ${HOME}/.local/share/powerline-bindings
safe_link ${POWERLINE_ROOT}/powerline/bindings/vim ${HOME}/.vim/plugged/powerline.vim

## rcfiles
safe_link ${PWD}/prompt.zsh ${HOME}/.config/zsh/prompt.zsh
safe_link ${PWD}/plugins.vim ${HOME}/.vim/plugins.vim
if [ ! -d ${HOME}/.config/powerline ]; then
    mkdir ${HOME}/.config/powerline
fi
safe_link ${PWD}/config.json ${HOME}/.config/powerline/config.json
safe_link ${PWD}/colors.json ${HOME}/.config/powerline/colors.json
safe_link ${PWD}/themes ${HOME}/.config/powerline/themes
safe_link ${PWD}/colorschemes ${HOME}/.config/powerline/colorschemes
