#!/bin/bash

# ZSH
ln -sf ${PWD}/zshrc ${HOME}/.zshrc

# completion of ZSH
if [ ! -d ${HOME}/.zcomp ]; then
    mkdir ${HOME}/.zcomp
fi
for f in ${PWD}/zcomp/*; do
    ln -sf $f ${HOME}/.zcomp/${f##*/}
done

# VIM
if [ ! -d ${HOME}/.vim ]; then
    mkdir ${HOME}/.vim
fi
for f in ${PWD}/vim/*; do
    ln -sf $f ${HOME}/.vim/${f##*/}
done

# latexmk
ln -sf ${PWD}/latexmkrc ${HOME}/.latexmkrc
