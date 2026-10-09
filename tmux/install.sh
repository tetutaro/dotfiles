#!/usr/bin/env bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"
# environment
os=$(uname -s)

if [ ! -d ${HOME}/.config/tmux ]; then
    mkdir ${HOME}/.config/tmux
fi

# tmux plugins
if [ ! -d ${HOME}/.config/tmux/plugins ]; then
    mkdir ${HOME}/.config/tmux/plugins
fi
if [ ! -d ${HOME}/.config/tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm
else
    echo "tpm is already installed"
fi
if [ ! -d ${HOME}/.config/tmux/plugins/tmux-copycat ]; then
    git clone https://github.com/tmux-plugins/tmux-copycat.git ~/.config/tmux/plugins/tmux-copycat
else
    echo "tmux-copycat is already installed"
fi
if [ ! -d ${HOME}/.config/tmux/plugins/tmux-sidebar ]; then
    git clone https://github.com/tmux-plugins/tmux-sidebar.git ~/.config/tmux/plugins/tmux-sidebar
else
    echo "tmux-sidebar is already installed"
fi
if [ ! -d ${HOME}/.config/tmux/plugins/tmux-powerline ]; then
    git clone https://github.com/erikw/tmux-powerline.git ~/.config/tmux/plugins/tmux-powerline
else
    echo "tmux-powerline is already installed"
fi

# config files
safe_link ${PWD}/tmux.zsh ${HOME}/.config/zsh/tmux.zsh
safe_link ${PWD}/tmux.conf ${HOME}/.config/tmux/tmux.conf
if [ "${os}" == "Linux" ]; then
    safe_link ${PWD}/copy.ubuntu.conf ${HOME}/.config/tmux/copy.conf
else
    safe_link ${PWD}/copy.macosx.conf ${HOME}/.config/tmux/copy.conf
fi
safe_link ${PWD}/status.conf ${HOME}/.config/tmux/status.conf
safe_link ${PWD}/style.conf ${HOME}/.config/tmux/style.conf
safe_link ${PWD}/tmux-powerline ${HOME}/.config/tmux-powerline
