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

## jupyterlab on pipx
if [[ ! -d "${HOME}/.local/pipx/venvs/jupyterlab" ]]; then
    pipx install jupyterlab
    pipx inject jupyterlab pip
    pipx runpip jupyterlab install black ruff jupyterlab-lsp python-lsp-server python-lsp-ruff jupyterlab-code-formatter jupyterlab-templates jupyterlab-widgets ipywidgets ipympl
    pipx run --spec jupyterlab jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyterlab-templates jupyter-matplotlib
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
if [[ ! -d ${HOME}/.jupyter/lab ]]; then
    mkdir ${HOME}/.jupyter/lab
fi
if [[ -e ${HOME}/.jupyter/lab/user-settings ]]; then
    rm -f ${HOME}/.jupyter/lab/user-settings
fi
if [[ ${os} == "Linux" ]]; then
    ln -sf ${PWD}/jupyter_lab_config.py.linux ${HOME}/.jupyter/jupyter_lab_config.py
elif [[ ${os} == "Darwin" ]]; then
    ln -sf ${PWD}/jupyter_lab_config.py.macos ${HOME}/.jupyter/jupyter_lab_config.py
fi
ln -sf ${PWD}/templates ${HOME}/.jupyter/templates
ln -sf ${PWD}/user-settings ${HOME}/.jupyter/lab/user-settings

## check the app is installed
if [[ "${os}" == "Linux" ]]; then
    if [[ -z $(command -v jlab) ]]; then
        echo "jupyterlab-desktop is already installed"
        exit 0
    fi
    wget https://github.com/jupyterlab/jupyterlab-desktop/releases/latest/download/JupyterLab-Setup-Debian.deb
    sudo dpkg -i JupyterLab-Setup-Debian.deb
    rm -f JupyterLab-Setup-Debian.deb
else
    if [[ -d "/Applications/JupyterLab.app" ]]; then
        echo "jupyterlab-desktop is already installed"
        exit 0
    fi
    wget https://github.com/jupyterlab/jupyterlab-desktop/releases/latest/download/JupyterLab-Setup-macOS-x64.dmg
    hdiutil attach JupyterLab-Setup-macOS-x64.dmg
    JDIR=$(find /Volumes -d 1 -name "JupyterLab*")
    sudo cp -R "${JDIR}/JupyterLab.app" /Applications
    hdiutil unmount "${JDIR}"
    rm -f JupyterLab-Setup-macOS-x64.dmg
fi
