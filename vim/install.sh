#!/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"
## OS
os=$(uname -s)

## RCFILES
if [ ! -d ${HOME}/.vim ]; then
    mkdir ${HOME}/.vim
fi
safe_link ${PWD}/vimrc ${HOME}/.vim/vimrc
safe_link ${PWD}/defaults.vim ${HOME}/.vim/defaults.vim
safe_link ${PWD}/plugins.vim ${HOME}/.vim/plugins.vim
safe_link ${PWD}/keymaps.vim ${HOME}/.vim/keymaps.vim
safe_link ${PWD}/gvimrc ${HOME}/.vim/gvimrc
if [ ! -f ${HOME}/.vim/colors.vim ]; then
    cp ${PWD}/colors.vim ${HOME}/.vim/colors.vim
fi

## VIM-PLUG
if [ ! -f ${HOME}/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vi
    vim -c PlugInstall -c quit -c quit
else
    echo "vim-plug is already installed"
fi
