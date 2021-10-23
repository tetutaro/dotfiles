#!/usr/bin/bash

os=$(uname -s)
if [ -z $(command -v tmux) ]; then
    if [ "${os}" == "Linux" ]; then
        sudo apt install tmux
    else
        brew install tmux
    fi
else
    echo "tmux is already installed"
fi

ln -sf ${PWD}/tmux.conf ${HOME}/.tmux.conf
if [ ! -d ${HOME}/.config/tmux ]; then
    mkdir -p ${HOME}/.config/tmux
fi
ln -sf ${PWD}/tmux.zsh ${HOME}/.config/tmux/tmux.zsh
