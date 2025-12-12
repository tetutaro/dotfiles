#!/usr/bin/bash

if [[ "x$(flatpak list | grep -i wezterm)" == "x" ]]; then
    flatpak install flathub com.wezfurlong.wezterm
    echo "WezTerm is installed."
else
    echo "WezTerm has already installed."
fi

if [[ ! -e ${HOME}/.config/wezterm/wezterm.lua ]]; then
    echo "Installing WezTerm configuration file..."
    mkdir -p ${HOME}/.config/wezterm
    ln -s ${PWD}/wezterm.lua ${HOME}/.config/wezterm/wezterm.lua
    echo "WezTerm configuration file installed"
else
    echo "WezTerm configuration file already exists."
fi
