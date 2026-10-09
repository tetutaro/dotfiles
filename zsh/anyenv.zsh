# path for local binaries
if [[ -d ${HOME}/.local/bin ]]; then
    export PATH=${HOME}/.local/bin:${PATH}
fi
# uv
if [[ $(command -v uv) ]]; then
    eval "$(uv generate-shell-completion zsh)"
fi
if [[ $(command -v uvx) ]]; then
    eval "$(uvx --generate-shell-completion zsh)"
fi
# yarn
if [[ -d ${HOME}/.yarn/bin ]]; then
    export PATH=${PATH}:${HOME}/.yarn/bin
fi
# cargo
if [[ -d ${HOME}/.cargo/bin ]]; then
    export PATH=${PATH}:${HOME}/.cargo/bin
fi
# mise
if [[ -f ${HOME}/.local/bin/mise ]]; then
    eval "$(${HOME}/.local/bin/mise activate zsh)"
fi
# if you use asdf instead of mise, uncomment below
## direnv
# if [[ -f ${HOME}/.config/asdf-direnv/zshrc ]]; then
#     source "${HOME}/.config/asdf-direnv/zshrc"
# fi
## asdf
# export ASDF_TOOL_VERSIONS_FILENAME=".tool-versions"
# export ASDF_DATA_DIR="${HOME}/.asdf"
# export ASDF_CONFIG_FILE="${HOME}/.asdfrc"
# export PATH="${ASDF_DATA_DIR}/shims:${PATH}"
