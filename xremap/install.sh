#!/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"
## check dependencies
os=$(uname -s)
if [ "${os}" != "Linux" ]; then
    exit 0
fi

if [ ! -x ${HOME}/.cargo/bin/xremap ]; then
    echo "install xremap"
    cargo install xremap --features wlroots
fi

# xremap reads /dev/input/event* and writes /dev/uinput (both group input)
if ! id -nG | grep -qw input; then
    echo "add ${USER} to the input group (re-login required)"
    sudo usermod -aG input ${USER}
fi

if [ ! -d ${HOME}/.config/xremap ]; then
    mkdir -p ${HOME}/.config/xremap
fi

safe_link ${PWD}/config.yml ${HOME}/.config/xremap/config.yml
safe_link ${PWD}/xremap.desktop ${HOME}/.config/autostart/xremap.desktop
