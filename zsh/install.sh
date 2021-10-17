#!/bin/bash

## get system name
os=$(uname -s)

## installation of fzf, silversearcher
if [[ -z fzf ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install fzf
    else
        brew install fzf
    fi
else
    echo "fzf is already installed"
fi
if [[ -z ag ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install silversearcher-ag
    else
        brew install ag
    fi
else
    echo "silversearcher is already installed"
fi

## path of python
if [[ "${os}" == "Linux" ]]; then
    PYTHON=/bin/python3
else
    PYTHON=/usr/local/bin/python3
fi

## pyenv
if [[ ! -d ${HOME}/.pyenv ]]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
else
    echo "pyenv is already installed"
fi
if [[ ! -d ${HOME}/.pyenv/plugins/pyenv-virtualenv ]]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
else
    echo "pyenv-virtualenv is already installed"
fi

## poetry
if [[ ! -d ${HOME}/.poetry ]]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | ${PYTHON} -
    export PATH=${HOME}/.poetry/bin:${PATH}
    rehash
    poetry config virtualenvs.path "${HOME}/.pyenv/versions"
else
    echo "poetry is already installed"
fi

## pipx
if [[ -z pipx ]]; then
    if [[ ${os} == "Darwin" ]]; then
        brew install pipx
    else
        ${PYTHON} -m pip install --local pipx
    fi
    export PATH=${PATH}:${HOME}/.local/bin
    rehash
    pipx ensurepath
else
    echo "pipx is already installed"
fi

## nodenv
if [[ ! -d ${HOME}/.nodenv ]]; then
    git clone git://github.com/nodenv/nodenv.git ~/.nodenv
else
    echo "nodenv is already installed"
fi
if [[ ! -d ${HOME}/.nodenv/plugins/node-build ]]; then
    git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
else
    echo "node-build is already installed"
fi
if [[ ! -d ${HOME}/.nodenv/plugins/node-build-update-defs ]]; then
    git clone https://github.com/nodenv/node-build-update-defs.git ~/.nodenv/plugins/node-build-update-defs
else
    echo "node-build-update-defs is already installed"
fi

## ZSHRCs
ln -sf ${PWD}/zshrc ${HOME}/.zshrc
ln -sf ${PWD}/zshrc.anyenv ${HOME}/.zshrc.anyenv
ln -sf ${PWD}/zshrc.cdp ${HOME}/.zshrc.cdp

## completion of ZSH
if [ ! -d ${HOME}/.zcomp ]; then
    mkdir ${HOME}/.zcomp
fi
for f in ${PWD}/zcomp/*; do
    ln -sf $f ${HOME}/.zcomp/${f##*/}
done

## installation of ZSH
if [ "${os}" == "Linux" ]; then
    ZSH_PATH="/usr/bin/zsh"
else
    ZSH_PATH="/usr/local/bin/zsh"
fi
if [ -z ${ZSH_PATH} ]; then
    if [ "${os}" == "Linux" ]; then
        sudo apt install zsh
    else
        brew install zsh
    fi
    chsh -s ${ZSH_PATH}
else
    echo "zsh is already installed"
fi
