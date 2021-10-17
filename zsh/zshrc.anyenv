# nodenv
if [[ -d ${HOME}/.nodenv ]]; then
    export PATH=${HOME}/.nodenv/bin:${PATH}
    eval "$(nodenv init -)"
    if [[ ! -d ${HOME}/.pyenv ]]; then
        alias rehash="nodenv rehash; rehash"
    fi
fi
# pyenv
if [[ -d ${HOME}/.pyenv ]]; then
    export PYENV_ROOT=${HOME}/.pyenv
    export PATH=${PYENV_ROOT}/bin:${PATH}
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    if [[ -d ${HOME}/.nodenv ]]; then
        alias rehash="nodenv rehash; pyenv rehash; rehash"
    else
        alias rehash="pyenv rehash; rehash"
    fi
fi
# pyenv-virtualenv
if [[ -d ${HOME}/.pyenv/plugins/pyenv-virtualenv ]]; then
    eval "$(pyenv virtualenv-init -)"
fi
# poetry
if [[ -d ${HOME}/.poetry ]]; then
    export PATH=${HOME}/.poetry/bin:${PATH}
fi
# pipx
if [[ -d ${HOME}/.local/bin ]]; then
    export PATH=${PATH}:${HOME}/.local/bin
fi
