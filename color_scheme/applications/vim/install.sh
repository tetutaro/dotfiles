#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ -L ${HOME}/.vim/colors ]; then
    rm -f ${HOME}/.vim/colors
fi
ln -sf ${SCRIPT_DIR}/colors ${HOME}/.vim/colors
