#!/usr/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"

if [[ "x$(flatpak list | grep -i GIMP)" == "x" ]]; then
    flatpak install flathub org.gimp.GIMP
    flatpak install flathub org.gimp.GIMP.Plugin.BIMP
    flatpak install flathub org.gimp.GIMP.Plugin.FocusBlur
    flatpak install flathub org.gimp.GIMP.Plugin.Fourier
    flatpak install flathub org.gimp.GIMP.Plugin.GMic
    flatpak install flathub org.gimp.GIMP.Plugin.Lensfun
    flatpak install flathub org.gimp.GIMP.Plugin.LiquidRescale
    flatpak install flathub org.gimp.GIMP.Plugin.Resynthesizer
    echo "GIMP is installed."
else
    echo "GIMP has already installed."
fi

## if GIMP is not recognized, symlink .desktop to local
# safe_link /var/lib/flatpak/app/org.gimp.GIMP/current/active/export/share/applications/org.gimp.GIMP.desktop ${HOME}/.local/share/applications/org.gimp.GIMP.desktop
