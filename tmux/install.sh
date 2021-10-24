#!/usr/bin/env bash

os=$(uname -s)
if [ -z $(command -v tmux) ]; then
    if [ "${os}" == "Linux" ]; then
        sudo apt install tmux
    else
        # https://github.com/tmux/tmux/issues/2262
        curl -OL https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color
        echo '8f259a31649900b9a8f71cbc28be762aa55206316d33d51fd8d08e4275b5f6a3  tmux-256color' | shasum -a 256 -c
        if [ $? == 0 ]; then
            /usr/bin/tic -x tmux-256color
        else
            echo "tmux-256color checksum has changed"
            exit 1
        fi
        rm -f tmux-256color
        # install tmux via homebrew
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
