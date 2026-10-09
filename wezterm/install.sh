#!/usr/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"

if [[ "x$(flatpak list | grep -i wezterm)" == "x" ]]; then
    flatpak install flathub com.wezfurlong.wezterm
    echo "WezTerm is installed."
else
    echo "WezTerm has already installed."
fi

echo "Installing WezTerm configuration file..."
safe_link ${PWD}/wezterm.lua ${HOME}/.config/wezterm/wezterm.lua
safe_link ${PWD}/keybinds.lua ${HOME}/.config/wezterm/keybinds.lua
echo "WezTerm configuration file installed"
