#!/bin/bash
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
if [ -e ${HOME}/.config/autokey/autokey.json ]; then
    rm -f ${HOME}/.config/autokey/autokey.json
fi
ln -sf ${PWD}/autokey.json ${HOME}/.config/autokey/autokey.json

if [ -e ${HOME}/.config/autokey/data ]; then
    rm -rf ${HOME}/.config/autokey/data
fi
ln -sf ${PWD}/data ${HOME}/.config/autokey/data
