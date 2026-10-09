#!/usr/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"

if [[ "x$(flatpak list | grep -i wezterm)" == "x" ]]; then
    flatpak install flathub org.wezfurlong.wezterm
    echo "WezTerm is installed."
else
    echo "WezTerm has already installed."
fi

echo "Installing WezTerm configuration file..."
safe_link ${PWD}/wezterm.lua ${HOME}/.config/wezterm/wezterm.lua
safe_link ${PWD}/keybinds.lua ${HOME}/.config/wezterm/keybinds.lua
conf="${HOME}/.local/share/applications/terminal.desktop"
mkdir -p "$(dirname "${conf}")" || return 1
if [[ -f ${conf} ]]; then
    rm -f ${conf}
fi
cat << 'EOF' > ${conf}
[Desktop Entry]
Name=Terminal
Comment=terminal emulator
Exec=flatpak run org.wezfurlong.wezterm
Terminal=false
Type=Application
Category=System;
Icon=Terminal
EOF
chmod +x ${conf}
echo "WezTerm configuration file installed"
