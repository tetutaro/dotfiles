#!/bin/bash
## OS
os=$(uname -s)

## dependencies
if [[ -z $(command -v yarn) ]]; then
    echo "install Node.js and yarn first"
    exit 1
fi

## RCFILES
if [ ! -d ${HOME}/.vim ]; then
    mkdir ${HOME}/.vim
fi
ln -sf ${PWD}/vimrc ${HOME}/.vim/vimrc
ln -sf ${PWD}/defaults.vim ${HOME}/.vim/defaults.vim
ln -sf ${PWD}/plugins.vim ${HOME}/.vim/plugins.vim
ln -sf ${PWD}/keymap.vim ${HOME}/.vim/keymap.vim
if [ ! -f ${HOME}/.vim/colors.vim ]; then
    cp $f ${HOME}/.vim/colors.vim
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
