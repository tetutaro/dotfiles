#!/usr/bin/bash

os=$(uname -s)

cd ${HOME}

# mise itself
if [[ ! -f "${HOME}/.local/bin/mise" ]]; then
    curl -fsSL https://mise.run | sh
fi

# zsh
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
fi

# vim
if [[ -z $(command -v vim) ]]; then
    mise install vim@latest
    mise use vim@latest
fi

# fzf
if [[ -z $(command -v fzf) ]]; then
    mise install fzf@latest
    mise use fzf@latest
    mkdir -p ${HOME}/.config/fzf
    fzf --zsh > ${HOME}/.config/fzf/fzf.zsh
fi

# ag (the silver searcher)
if [[ -z $(command -v ag) ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install -y silversearcher-ag
    else
        brew install ag
    fi
fi

# tree
if [[ -z $(command -v tree) ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install -y tree
    else
        brew install tree
    fi
fi

# xsel
if [[ "${os}" == "Linux" ]]; then
    if [[ -z $(command -v xsel) ]]; then
        sudo apt install -y xsel
    fi
fi

# herdr
if [[ -z $(command -v herdr) ]]; then
    mise install herdr@latest
    mise use herdr@latest
fi

# uv
if [[ -z $(command -v uv) ]]; then
    mise install uv@latest
    mise use uv@latest
fi

# python
if [[ ! -d ${HOME}/.local/share/mise/installs/python ]]; then
    mise install python@3.13.16
    mise use python@3.13.16
fi

# nodejs
if [[ -z $(command -v node) ]]; then
    mise install node@24.21.0
    mise use node@24.21.0
fi

# pipx
if [[ -z $(command -v pipx) ]]; then
    uv tool install pipx
    pipx ensurepath
fi

# yarn
if [[ -z $(command -v yarn) ]]; then
    npm install -g yarn
fi

# typescript-language-server
if [[ -z $(command -v typescript-language-server) ]]; then
    yarn global add typescript typescript-language-server
fi

# docker
if [[ -z $(command -v docker) ]]; then
    if [[ "${os}" == "Linux" ]]; then
        # required libraries
        sudo apt update
        sudo apt install -y ca-certificates curl gnupg gnupg2
        # docker
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
        sudo apt update
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        # NVIDIA Container Toolkit
        curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
        sudo apt update
        export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.20.1-1 sudo apt-get install -y nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}
        sudo nvidia-ctk runtime configure --runtime=docker
	sudo systemctl restart docker
    fi
fi

cd -
