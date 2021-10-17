#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ -L ${HOME}/.config/color_scheme_shell ]; then
    rm -f ${HOME}/.config/color_scheme_shell
fi
ln -s ${SCRIPT_DIR}/scripts ${HOME}/.config/color_scheme_shell
