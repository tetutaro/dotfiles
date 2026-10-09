#!/usr/bin/env bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"
if [ ! -d ${HOME}/.config/herdr ]; then
    mkdir ${HOME}/.config/herdr
fi

# config files
safe_link ${PWD}/tmux.zsh ${HOME}/.config/zsh/tmux.zsh
safe_link ${PWD}/config.toml ${HOME}/.config/herdr/config.toml
