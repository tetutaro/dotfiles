#!/bin/bash

## get system name
os=$(uname -s)

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

# create completion of docker
if [ "${os}" == "Linux" ]; then
    docker completion zsh > ${HOME}/.config/zsh-completions/_docker
fi

# copy completion of cargo
cargo_comp="${HOME}/.asdf/rust/$(asdf current rust | sed -e \"s/ \+/\t/g\" | cut -f2)/share/zsh/site-functions/_cargo"
if [ -f ${cargo_comp} ]; then
    cp ${cargo_comp} ${HOME}/.config/zsh-completions/_cargo
fi

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
