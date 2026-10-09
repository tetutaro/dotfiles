#!/usr/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"

if [[ -z $(command -v ghostty) ]]; then
    sudo apt install ghostty
    echo "Ghostty is installed."
else
    echo "Ghostty has already installed."
fi

echo "Installing Ghostty configuration file..."
safe_link ${PWD}/config.ghostty ${HOME}/.config/ghostty/config.ghostty
echo "Ghostty configuration file installed"
