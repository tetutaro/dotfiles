#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ -L ${HOME}/.config/color_scheme/tmux ]; then
    rm -f ${HOME}/.config/color_scheme/tmux
fi
