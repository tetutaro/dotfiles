#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/applications/shell && ./install.sh && cd -
cd ${SCRIPT_DIR}/applications/fzf && ./install.sh && cd -
cd ${SCRIPT_DIR}/applications/vim && ./install.sh && cd -
cd ${SCRIPT_DIR}/applications/tmux && ./install.sh && cd -
cd ${SCRIPT_DIR}/applications/powerline && ./install.sh && cd -
cd ${SCRIPT_DIR}/manager && ./install.sh && cd -
if [ ! -d ${HOME}/.config/color_scheme ]; then
    mkdir ${HOME}/.config/color_scheme
fi
ln -sf ${SCRIPT_DIR}/scripts/color_scheme.sh ${HOME}/.config/color_scheme/color_scheme.sh
