#!/bin/bash

## get system name
os=$(uname -s)

## installation of fzf, silversearcher, tree
if [[ ! -d ${HOME}/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish
else
    echo "fzf is already installed"
fi
if [[ -z $(command -v ag) ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install silversearcher-ag
    else
        brew install ag
    fi
else
    echo "silversearcher is already installed"
fi
if [[ -z $(command -v tree) ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install tree
    else
        brew install tree
    fi
else
    echo "tree is already installed"
fi
## installation of xsel
if [[ "${os}" == "Linux" ]]; then
    if [[ -z $(command -v xsel) ]]; then
        sudo apt install xsel
    else
        echo "xsel is already installed"
    fi
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
if [[ ! -d ${HOME}/.pyenv/plugins/pyenv-update ]]; then
    git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update
else
    echo "pyenv-update is already installed"
fi

## nodenv
if [[ ! -d ${HOME}/.nodenv ]]; then
    git clone https://github.com/nodenv/nodenv.git ~/.nodenv
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
if [[ ! -d ${HOME}/.nodenv/plugins/nodenv-update ]]; then
    git clone https://github.com/nodenv/nodenv-update.git ~/.nodenv/plugins/nodenv-update
else
    echo "nodenv-update is already installed"
fi

## ZSHRCs
ln -sf ${PWD}/zshrc ${HOME}/.zshrc
if [[ ! -d ${HOME}/.config/zsh ]]; then
    mkdir ${HOME}/.config/zsh
fi
ln -sf ${PWD}/prompt.zsh ${HOME}/.config/zsh/prompt.zsh
ln -sf ${PWD}/tmux.zsh ${HOME}/.config/zsh/tmux.zsh
ln -sf ${PWD}/fzf.zsh ${HOME}/.config/zsh/fzf.zsh
ln -sf ${PWD}/cdp.zsh ${HOME}/.config/zsh/cdp.zsh
ln -sf ${PWD}/anyenv.zsh ${HOME}/.config/zsh/anyenv.zsh

## completion of ZSH
if [ ! -d ${HOME}/.config/zsh-completions ]; then
    mkdir ${HOME}/.config/zsh-completions
fi
for f in ${PWD}/zsh-completions/*; do
    ln -sf $f ${HOME}/.config/zsh-completions/${f##*/}
done
# download completion of docker, docker-compose
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker -o ${HOME}/.config/zsh-completions/_docker
curl -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/zsh/_docker-compose  -o ${HOME}/.config/zsh-completions/_docker-compose

## installation of ZSH
if [ "${os}" == "Linux" ]; then
    ZSH_PATH="/usr/bin/zsh"
else
    ZSH_PATH="/usr/local/bin/zsh"
fi
if [[ ! -x ${ZSH_PATH} ]]; then
    if [ "${os}" == "Linux" ]; then
        sudo apt install zsh
    else
        brew install zsh
    fi
    chsh -s ${ZSH_PATH}
else
    echo "zsh is already installed"
fi
