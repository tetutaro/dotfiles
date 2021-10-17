#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ -d ${HOME}/.config/color_scheme_fzf ]; then
    rm -rf ${HOME}/.config/color_scheme_fzf
fi
