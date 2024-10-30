#!/bin/bash
## OS
os=$(uname -s)

## RCFILES
if [ ! -d ${HOME}/.vim ]; then
    mkdir ${HOME}/.vim
fi
ln -sf ${PWD}/vimrc ${HOME}/.vim/vimrc
ln -sf ${PWD}/defaults.vim ${HOME}/.vim/defaults.vim
ln -sf ${PWD}/plugins.vim ${HOME}/.vim/plugins.vim
ln -sf ${PWD}/keymaps.vim ${HOME}/.vim/keymaps.vim
ln -sf ${PWD}/gvimrc ${HOME}/.vim/gvimrc
if [ ! -f ${HOME}/.vim/colors.vim ]; then
    cp ${PWD}/colors.vim ${HOME}/.vim/colors.vim
fi

## VIM
if [ "${os}" == "Linux" ]; then
    VIM_PATH=/usr/bin/vim
else
    VIM_PATH=/usr/local/bin/vim
fi
if [ ! -f ${VIM_PATH} ]; then
    if [ "${os}" == "Linux" ]; then
        sudo apt install vim-gtk3
    else
        brew install vim
    fi
else
    echo "vim is already installed"
fi

## VIM-PLUG
if [ ! -f ${HOME}/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vi
    vim -c PlugInstall -c quit -c quit
else
    echo "vim-plug is already installed"
fi
