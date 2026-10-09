#!/usr/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"

if [[ "x$(flatpak list | grep -i KeePassXC)" == "x" ]]; then
    flatpak install flathub org.keepassxc.KeePassXC
    echo "KeePassXC is installed."
else
    echo "KeePassXC has already installed."
fi

## if KeePassXC is not recognized, symlink .desktop to local
# safe_link /var/lib/flatpak/app/org.keepassxc.KeePassXC/current/active/export/share/applications/org.keepassxc.KeePassXC.desktop ${HOME}/.local/share/applications/org.keepassxc.KeePassXC.desktop
