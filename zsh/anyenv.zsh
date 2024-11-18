# asdf
if [[ -d ${HOME}/.asdf ]]; then
    . "${HOME}/.asdf/asdf.sh"
fi
# uv
if [[ $(command -v uv) ]]; then
    eval "$(uv generate-shell-completion zsh)"
fi
if [[ $(command -v uvx) ]]; then
    eval "$(uvx --generate-shell-completion zsh)"
fi
# pipx
if [[ -d ${HOME}/.local/bin ]]; then
    export PATH=${PATH}:${HOME}/.local/bin
fi
# yarn
if [[ -d ${HOME}/.yarn/bin ]]; then
    export PATH=${PATH}:${HOME}/.yarn/bin
fi
# cargo
if [[ -d ${HOME}/.cargo/bin ]]; then
    export PATH=${PATH}:${HOME}/.cargo/bin
fi
# direnv
if [[ -f ${HOME}/.config/asdf-direnv/zshrc ]]; then
    source "${HOME}/.config/asdf-direnv/zshrc"
fi
