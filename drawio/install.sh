#!/usr/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"

if [[ "x$(flatpak list | grep -i drawio)" == "x" ]]; then
    flatpak install flathub com.jgraph.drawio.desktop
    echo "drawio is installed."
else
    echo "drawio has already installed."
fi

## if drawio is not recognized, copy .desktop to local
# safe_link /var/lib/flatpak/app/com.jgraph.drawio.desktop/current/active/export/share/applications/com.jgraph.drawio.desktop.desktop ${HOME}/.local/share/applications/com.jgraph.drawio.desktop.desktop
