#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ -L ${HOME}/.config/color_scheme/shell ]; then
    rm -f ${HOME}/.config/color_scheme/shell
fi
