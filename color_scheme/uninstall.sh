#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/applications/shell && ./uninstall.sh && cd -
cd ${SCRIPT_DIR}/applications/fzf && ./uninstall.sh && cd -
cd ${SCRIPT_DIR}/applications/vim && ./uninstall.sh && cd -
cd ${SCRIPT_DIR}/applications/tmux && ./uninstall.sh && cd -
cd ${SCRIPT_DIR}/applications/powerline && ./uninstall.sh && cd -
cd ${SCRIPT_DIR}/manager && ./uninstall.sh && cd -
if [ -d ${HOME}/.config/color_scheme ]; then
    rm -rf ${HOME}/.config/color_scheme
fi
