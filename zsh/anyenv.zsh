# nodenv
if [[ -d ${HOME}/.nodenv ]]; then
    export PATH=${HOME}/.nodenv/bin:${PATH}
    eval "$(nodenv init -)"
fi
# phpenv
if [[ -d ${HOME}/.phpenv ]]; then
    export PATH=${HOME}/.phpenv/bin:${PATH}
    eval "$(phpenv init -)"
fi
# pyenv
if [[ -d ${HOME}/.pyenv ]]; then
    export PYENV_ROOT=${HOME}/.pyenv
    export PATH=${PYENV_ROOT}/bin:${PATH}
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi
# pyenv-virtualenv
if [[ -d ${HOME}/.pyenv/plugins/pyenv-virtualenv ]]; then
    eval "$(pyenv virtualenv-init -)"
fi
# poetry & pipx
if [[ -d ${HOME}/.local/bin ]]; then
    export PATH=${PATH}:${HOME}/.local/bin
fi

# rehash
function rehash() {
    if [[ -d ${HOME}/.nodenv ]]; then
        nodenv rehash
    fi
    if [[ -d ${HOME}/.pyenv ]]; then
        pyenv rehash
    fi
    if [[ -d ${HOME}/.phpenv ]]; then
        phpenv rehash
    fi
    builtin rehash
}
