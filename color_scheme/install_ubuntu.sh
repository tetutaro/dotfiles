#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/applications/shell && ./install.sh && cd -
cd ${SCRIPT_DIR}/applications/fzf && ./install_ubuntu.sh && cd -
cd ${SCRIPT_DIR}/applications/vim && ./install.sh && cd -
cd ${SCRIPT_DIR}/manager && ./install.sh && cd -
ln -sf ${SCRIPT_DIR}/zshrc.color_scheme ${HOME}/.zshrc.color_scheme
