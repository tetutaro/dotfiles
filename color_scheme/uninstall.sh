#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/applications/shell && ./uninstall.sh && cd -
cd ${SCRIPT_DIR}/applications/fzf && ./uninstall.sh && cd -
cd ${SCRIPT_DIR}/applications/vim && ./uninstall.sh && cd -
cd ${SCRIPT_DIR}/manager && ./uninstall.sh && cd -
if [ -L ${HOME}/.fzf.bash ]; then
    rm -f ${HOME}/.fzf.bash
fi
if [ -L ${HOME}/.fzf.zsh ]; then
    rm -f ${HOME}/.fzf.zsh
fi
if [ -f ${HOME}/.vim/colors.vim ]; then
    rm -f ${HOME}/.vim/colors.vim
    touch ${HOME}/.vim/colors.vim
fi
if [ -L ${HOME}/.zshrc.color_scheme ]; then
    rm -f ${HOME}/.zshrc.color_scheme
fi
