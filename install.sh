#!/bin/bash

# get system name
os=$(uname -s)

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

# JupyterLab on pipx (> pipx install jupyterlab)
# + yapyterlab_app (https://github.com/tetutaro/yapyterlab_app)
pipx_jupyterlab_etc=${HOME}/.local/pipx/venvs/jupyterlab/etc/jupyter
if [ -d ${pipx_jupyterlab_etc} ]; then
    if [ ${os} == "Linux" ]; then
        ln -sf ${PWD}/jupyter_lab_config.py.linux ${pipx_jupyterlab_etc}/jupyter_lab_config.py
    elif [ ${os} == "Darwin" ]; then
        ln -sf ${PWD}/jupyter_lab_config.py.macos ${pipx_jupyterlab_etc}/jupyter_lab_config.py
    fi
fi

# latexmk
ln -sf ${PWD}/latexmkrc ${HOME}/.latexmkrc
