#!/usr/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"

if [[ -z $(command -v rofi) ]]; then
    sudo apt install rofi
    echo "Rofi is installed."
else
    echo "Rofi has already installed."
fi

echo "Installing Rofi configuration file..."
safe_link ${PWD}/config.rasi ${HOME}/.config/rofi/config.rasi
echo "Rofi configuration file installed"
