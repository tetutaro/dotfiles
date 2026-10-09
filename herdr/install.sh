#!/usr/bin/env bash
if [ ! -d ${HOME}/.config/herdr ]; then
    mkdir ${HOME}/.config/herdr
fi

# config files
ln -sf ${PWD}/herdr.zsh ${HOME}/.config/zsh/tmux.zsh
ln -sf ${PWD}/config.toml ${HOME}/.config/herdr/config.toml
