#!/bin/bash
## check dependencies
os=$(uname -s)
if [ -z $(command -v pipx) ]; then
    echo "install pipx first"
    exit 1
else
    echo "pipx is already installed"
fi
if [ -z $(command -v zsh) ]; then
    echo "install zsh first"
    exit 1
else
    echo "zsh is already installed"
fi
if [ -z $(command -v vim) ]; then
    echo "install vim first"
    exit 1
else
    echo "vim is already installed"
fi

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
ln -sf ${POWERLINE_ROOT}/powerline/bindings ${HOME}/.local/share/powerline-bindings
ln -sf ${POWERLINE_ROOT}/powerline/bindings/vim ${HOME}/.vim/plugged/powerline.vim

## rcfiles
ln -sf ${PWD}/prompt.zsh ${HOME}/.config/zsh/prompt.zsh
ln -sf ${PWD}/plugins.vim ${HOME}/.vim/plugins.vim
if [ ! -d ${HOME}/.config/powerline ]; then
    mkdir ${HOME}/.config/powerline
fi
ln -sf ${PWD}/config.json ${HOME}/.config/powerline/config.json
ln -sf ${PWD}/colors.json ${HOME}/.config/powerline/colors.json
if [ -L ${HOME}/.config/powerline/themes ]; then
    rm -f ${HOME}/.config/powerline/themes
fi
ln -sf ${PWD}/themes ${HOME}/.config/powerline/themes
if [ -L ${HOME}/.config/powerline/colorschemes ]; then
    rm -f ${HOME}/.config/powerline/colorschemes
fi
ln -sf ${PWD}/colorschemes ${HOME}/.config/powerline/colorschemes
