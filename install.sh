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

# JupyterLab
if [ ! -d ${HOME}/.jupyter ]; then
    mkdir ${HOME}/.jupyter
fi
if [ ! -d ${HOME}/.jupyter/lab ]; then
    mkdir ${HOME}/.jupyter/lab
fi
if [ -e ${HOME}/.jupyter/lab/user-settings ]; then
    rm -rf ${HOME}/.jupyter/lab/user-settings
fi
ln -sf ${PWD}/jupyterlab ${HOME}/.jupyter/lab/user-settings

# latexmk
ln -sf ${PWD}/latexmkrc ${HOME}/.latexmkrc
