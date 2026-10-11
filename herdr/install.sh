#!/usr/bin/env bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"
if [ ! -d ${HOME}/.config/herdr ]; then
    mkdir ${HOME}/.config/herdr
fi

# config files
safe_link ${PWD}/tmux.zsh ${HOME}/.config/zsh/tmux.zsh
safe_link ${PWD}/config.toml ${HOME}/.config/herdr/config.toml
safe_link ${PWD}/scripts ${HOME}/.config/herdr/scripts
mkdir -p ${HOME}/.config/herdr/plugins/config/herdr-statusline
safe_link ${PWD}/herdr-statusline/config.toml ${HOME}/.config/herdr/plugins/config/herdr-statusline/config.toml
safe_link ${PWD}/herdr-statusline/powerline-tabs.sh ${HOME}/.config/herdr/plugins/config/herdr-statusline/powerline-tabs.sh
safe_link ${PWD}/herdr-statusline/agent-status.sh ${HOME}/.config/herdr/plugins/config/herdr-statusline/agent-status.sh
