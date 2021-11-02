#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ ! -d ${HOME}/.config/color_scheme ]; then
    mkdir ${HOME}/.config/color_scheme
fi
ln -sf ${SCRIPT_DIR}/style ${HOME}/.config/color_scheme/tmux
