#!/bin/bash
## check dependencies
os=$(uname -s)
if [[ "${os}" == "Linux" ]]; then
    PIPX_PATH="${HOME}/.local/bin/pipx"
else
    PIPX_PATH="/usr/local/bin/pipx"
fi
if [[ ! -f ${PIPX_PATH} ]]; then
    echo "install pipx first"
    exit 1
else
    echo "pipx is already installed"
fi
if [[ ! -d ${HOME}/.nodenv ]]; then
    echo "install nodenv first"
    exit 1
else
    echo "nodenv is already installed"
fi
if [[ -z $(command -v npm) ]]; then
    echo "install Node.js first"
    exit 1
else
    echo "Node.js is already installed"
fi
if [[ -z $(command -v yarn) ]]; then
    echo "install yarn"
    npm install -g yarn
else
    echo "yarn is already installed"
fi
if [[ -z $(command -v jq) ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install jq
    else
        brew install jq
    fi
    rehash
else
    echo "jq is already installed"
fi

## get version
VERSION=$(cat package.json | jq -r .version)

## jupyterlab on pipx
if [[ ! -d "${HOME}/.local/pipx/venvs/jupyterlab" ]]; then
    pipx install jupyterlab
    pipx inject jupyterlab pip
    pipx runpip jupyterlab install black flake8 python-lsp-server jupyterlab-code-formatter jupyterlab-lsp jupyterlab-templates jupyterlab-widgets ipywidgets
    pipx run --spec jupyterlab jupyter labextension install @jupyter-widgets/jupyterlab-manager @jupyterlab/toc jupyterlab_templates
    pipx run --spec jupyterlab jupyter lab build
    pipx run --spec jupyterlab jupyter lab clean
else
    echo "JupyterLab server is already installed"
fi

## user-settings
if [[ ! -d ${HOME}/.jupyter ]]; then
    mkdir ${HOME}/.jupyter
fi
if [[ -e ${HOME}/.jupyter/jupyter_lab_config.py ]]; then
    rm -f ${HOME}/.jupyter/jupyter_lab_config.py
fi
if [[ -e ${HOME}/.jupyter/templates ]]; then
    rm -f ${HOME}/.jupyter/templates
fi
if [[ -e ${HOME}/.jupyter/flake8 ]]; then
    rm -f ${HOME}/.jupyter/flake8
fi
if [[ ! -d ${HOME}/.jupyter/lab ]]; then
    mkdir ${HOME}/.jupyter/lab
fi
if [[ -e ${HOME}/.jupyter/lab/user-settings ]]; then
    rm -f ${HOME}/.jupyter/lab/user-settings
fi
if [[ ${os} == "Linux" ]]; then
    cp ${PWD}/jupyter_lab_config.py.linux ${HOME}/.jupyter/jupyter_lab_config.py
elif [[ ${os} == "Darwin" ]]; then
    cp ${PWD}/jupyter_lab_config.py.macos ${HOME}/.jupyter/jupyter_lab_config.py
fi
echo "c.JupyterLabTemplates.template_dirs = ['${HOME}/.jupyter/templates']" >> ${HOME}/.jupyter/jupyter_lab_config.py
ln -sf ${PWD}/templates ${HOME}/.jupyter/templates
ln -sf ${PWD}/flake8 ${HOME}/.jupyter/flake8
ln -sf ${PWD}/user-settings ${HOME}/.jupyter/lab/user-settings

## check the app is installed
if [[ "${os}" == "Linux" ]]; then
    if [[ "$(snap list | grep jupyterlab)" != "" ]]; then
        echo "JupyterLab.app is already installed"
        exit 0
    fi
else
    if [[ -d "/Applications/JupyterLab.app" ]]; then
        echo "JupyterLab.app is already installed"
        exit 0
    fi
fi

## build the app
yarn
yarn build

## install the app
if [[ "${os}" == Linux ]]; then
    sudo snap install --dangerous build/JupyterLab_${VERSION}_amd64.snap
else
    open build/JupyterLab_${VERSION}.dmg
fi
