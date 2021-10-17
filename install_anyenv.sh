#!/usr/bin/env bash
os=$(uname -s)
if [[ "${os}" == "Linux" ]]; then
    PYTHON=/bin/python3
else
    PYTHON=/usr/local/bin/python3
fi
if [[ ! -z pipx ]]; then
    echo "Z"
fi
exit

## pyenv
if [[ ! -d ${HOME}/.pyenv ]]; then
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi
if [[ ! -d ${HOME}/.pyenv/plugins/pyenv-virtualenv ]]; then
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
fi

## poetry
if [[ ! -d ${HOME}/.poetry ]]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | ${PYTHON} -
    export PATH=${HOME}/.poetry/bin:${PATH}
    rehash
    poetry config virtualenvs.path "${HOME}/.pyenv/versions"
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
fi

## nodenv
if [[ ! -d ${HOME}/.nodenv ]]; then
    git clone git://github.com/nodenv/nodenv.git ~/.nodenv
fi
if [[ ! -d ${HOME}/.nodenv/plugins/node-build ]]; then
    git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
fi
if [[ ! -d ${HOME}/.nodenv/plugins/node-build-update-defs ]]; then
    git clone https://github.com/nodenv/node-build-update-defs.git ~/.nodenv/plugins/node-build-update-defs
fi
