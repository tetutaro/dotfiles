#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ ! -d ${HOME}/.config/color_scheme ]; then
    mkdir ${HOME}/.config/color_scheme
fi
ln -fs ${SCRIPT_DIR}/scripts ${HOME}/.config/color_scheme/fzf
