#!/usr/bin/env bash
os=$(uname -s)
if [[ -z fzf ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install fzf silversearcher-ag
    else
        brew install fzf ag
    fi
else
    echo "fzf is already installed"
fi
