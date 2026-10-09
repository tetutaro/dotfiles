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

# create completion of docker
if [ "${os}" == "Linux" ]; then
    docker completion zsh > ${HOME}/.config/zsh-completions/_docker
fi

# copy completion of cargo
# cargo_comp="${HOME}/.asdf/rust/$(asdf current rust | sed -e \"s/ \+/\t/g\" | cut -f2)/share/zsh/site-functions/_cargo"
# if [ -f ${cargo_comp} ]; then
#     cp ${cargo_comp} ${HOME}/.config/zsh-completions/_cargo
# fi
