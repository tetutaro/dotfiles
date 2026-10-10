#!/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"

## get system name
os=$(uname -s)

## ZSHRCs
safe_link ${PWD}/zshrc ${HOME}/.zshrc
if [[ ! -d ${HOME}/.config/zsh ]]; then
    mkdir ${HOME}/.config/zsh
fi
safe_link ${PWD}/prompt.zsh ${HOME}/.config/zsh/prompt.zsh
safe_link ${PWD}/tmux.zsh ${HOME}/.config/zsh/tmux.zsh
safe_link ${PWD}/fzf.zsh ${HOME}/.config/zsh/fzf.zsh
safe_link ${PWD}/cdp.zsh ${HOME}/.config/zsh/cdp.zsh
safe_link ${PWD}/anyenv.zsh ${HOME}/.config/zsh/anyenv.zsh

## completion of ZSH
if [ ! -d ${HOME}/.config/zsh-completions ]; then
    mkdir ${HOME}/.config/zsh-completions
fi
for f in ${PWD}/zsh-completions/*; do
    safe_link $f ${HOME}/.config/zsh-completions/${f##*/}
done
# completion of mise
if [[ ! -z $(command -v mise) ]]; then
    mise completion zsh > ${HOME}/.config/zsh-completions/_mise
fi
# completion of rustup, cargo
rustup completions zsh > ${HOME}/.config/zsh-completions/_rustup
rustup completions zsh cargo > ${HOME}/.config/zsh-completions/_cargo
# completion of herdr
herdr completion zsh > ${HOME}/.config/zsh-completions/_herdr
# completion of uv
uv generate-shell-completion zsh > ${HOME}/.config/zsh-completions/_uv
# completion of docker
if [ "${os}" == "Linux" ]; then
    docker completion zsh > ${HOME}/.config/zsh-completions/_docker
fi
