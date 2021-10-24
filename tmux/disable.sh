#!/usr/bin/env bash

if [ ! -d ${HOME}/.config/tmux ]; then
    mkdir -p ${HOME}/.config/tmux
fi
ln -sf ${PWD}/disable_tmux.zsh ${HOME}/.config/tmux/tmux.zsh
