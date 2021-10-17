#!/bin/bash
## check dependencies
os=$(uname -s)
if [ ! -f ${HOME}/.local/bin/pipx ]; then
    echo "install pipx first"
    exit 1
else
    echo "pipx is already installed"
fi
if [ ! -d ${HOME}/.nodenv ]; then
    echo "install nodenv first"
    exit 1
else
    echo "nodenv is already installed"
fi
if [ -z npm ]; then
    echo "install Node.js first"
    exit 1
else
    echo "Node.js is already installed"
fi
if [ -z yarn ]; then
    echo "install yarn"
    npm install -g yarn
else
    echo "yarn is already installed"
fi
if [ -z jq ]; then
    if [ "${os}" == "Linux" ]; then
        sudo apt install jq
    else
        brew install jq
    fi
    rehash
else
    echo "jq is already installed"
fi

## get version
VERSION=$(cat package.json | jq -r .version)

## jupyterlab on pipx
if [ ! -d ${HOME}/.local/pipx/venvs/jupyterlab ]; then
    pipx install jupyterlab
    pipx inject jupyterlab pip
    pipx runpip jupyterlab install "python-lsp-server[all]"
    pipx runpip jupyterlab install jupyterlab-lsp
else
    echo "JupyterLab server is already installed"
fi

## user-settings
if [ ! -d ${HOME}/.jupyter ]; then
    mkdir ${HOME}/.jupyter
fi
if [ ! -d ${HOME}/.jupyter/lab ]; then
    mkdir ${HOME}/.jupyter/lab
fi
if [ -e ${HOME}/.jupyter/lab/user-settings ]; then
    rm -rf ${HOME}/.jupyter/lab/user-settings
fi
ln -sf ${PWD}/user-settings ${HOME}/.jupyter/lab/user-settings

## server settings
pipx_jupyterlab_etc=${HOME}/.local/pipx/venvs/jupyterlab/etc/jupyter
if [ -d ${pipx_jupyterlab_etc} ]; then
    if [ ${os} == "Linux" ]; then
        ln -sf ${PWD}/jupyter_lab_config.py.linux ${pipx_jupyterlab_etc}/jupyter_lab_config.py
    elif [ ${os} == "Darwin" ]; then
        ln -sf ${PWD}/jupyter_lab_config.py.macos ${pipx_jupyterlab_etc}/jupyter_lab_config.py
    fi
fi

## check the app is installed
if [ "${os}" == "Linux" ]; then
    if [ "$(snap list | grep jupyterlab)" != "" ]; then
        echo "JupyterLab.app is already installed"
        exit 0
    fi
else
    if [ -d "/Applications/JupyterLab.app" ]; then
        echo "JupyterLab.app is already installed"
        exit 0
    fi
fi

## build the app
yarn
yarn build

## install the app
if [ "${os}" == Linux ]; then
    sudo snap install --dangerous build/JupyterLab_${VERSION}_amd64.snap
else
    open build/JupyterLab_${VERSION}.dmg
fi
