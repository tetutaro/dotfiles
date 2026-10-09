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
conf="${HOME}/.local/share/applications/terminal.desktop"
mkdir -p "$(dirname "${conf}")" || return 1
if [[ -f ${conf} ]]; then
    rm -f ${conf}
fi
cat << 'EOF' > ${conf}
[Desktop Entry]
Name=Terminal
Comment=terminal emulator
Exec=ghostty
Terminal=false
Type=Application
Category=System;
Icon=Terminal
EOF
chmod +x ${conf}
echo "Ghostty configuration file installed"
