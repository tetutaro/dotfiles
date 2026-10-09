#!/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"
## check dependencies
os=$(uname -s)
if [ "${os}" != "Linux" ]; then
    exit 0
fi

if [ -z $(command -v autokey) ]; then
    echo "install autokey"
    sudo apt install autokey-gtk
fi

if [ ! -d ${HOME}/.config/autokey ]; then
    mkdir -p ${HOME}/.config/autokey
fi

# safe_link ${PWD}/autokey.json ${HOME}/.config/autokey/autokey.json
safe_link ${PWD}/data ${HOME}/.config/autokey/data
