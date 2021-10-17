#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ -d ${HOME}/.config/color_scheme_fzf ]; then
    rm -rf ${HOME}/.config/color_scheme_fzf
fi
mkdir ${HOME}/.config/color_scheme_fzf
ln -s ${SCRIPT_DIR}/bash_ubuntu ${HOME}/.config/color_scheme_fzf/bash
ln -s ${SCRIPT_DIR}/zsh_ubuntu ${HOME}/.config/color_scheme_fzf/zsh
