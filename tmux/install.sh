#!/usr/bin/env bash
# environment
os=$(uname -s)

# tmux
if [ -z $(command -v tmux) ]; then
    if [ "${os}" == "Linux" ]; then
        sudo apt install tmux
    else
        # https://github.com/tmux/tmux/issues/2262
        curl -OL https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color
        echo '8f259a31649900b9a8f71cbc28be762aa55206316d33d51fd8d08e4275b5f6a3  tmux-256color' | shasum -a 256 -c
        if [ $? == 0 ]; then
            /usr/bin/tic -x tmux-256color
        else
            echo "tmux-256color checksum has changed"
            exit 1
        fi
        rm -f tmux-256color
        # install tmux via homebrew
        brew install tmux
    fi
else
    echo "tmux is already installed"
fi

if [ ! -d ${HOME}/.config/tmux ]; then
    mkdir ${HOME}/.config/tmux
fi

# tmux plugins
if [ ! -d ${HOME}/.config/tmux/plugins ]; then
    mkdir ${HOME}/.config/tmux/plugins
fi
if [ ! -d ${HOME}/.config/tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm
else
    echo "tpm is already installed"
fi
if [ ! -d ${HOME}/.config/tmux/plugins/tmux-copycat ]; then
    git clone https://github.com/tmux-plugins/tmux-copycat.git ~/.config/tmux/plugins/tmux-copycat
else
    echo "tmux-copycat is already installed"
fi
if [ ! -d ${HOME}/.config/tmux/plugins/tmux-sidebar ]; then
    git clone https://github.com/tmux-plugins/tmux-sidebar.git ~/.config/tmux/plugins/tmux-sidebar
else
    echo "tmux-sidebar is already installed"
fi
if [ ! -d ${HOME}/.config/tmux/plugins/tmux-powerline ]; then
    git clone https://github.com/erikw/tmux-powerline.git ~/.config/tmux/plugins/tmux-powerline
else
    echo "tmux-powerline is already installed"
fi

# config files
ln -sf ${PWD}/tmux.zsh ${HOME}/.config/zsh/tmux.zsh
ln -sf ${PWD}/tmux.conf ${HOME}/.config/tmux/tmux.conf
if [ "${os}" == "Linux" ]; then
    ln -sf ${PWD}/copy.ubuntu.conf ${HOME}/.config/tmux/copy.conf
else
    ln -sf ${PWD}/copy.macosx.conf ${HOME}/.config/tmux/copy.conf
fi
ln -sf ${PWD}/status.conf ${HOME}/.config/tmux/status.conf
ln -sf ${PWD}/style.conf ${HOME}/.config/tmux/style.conf
ln -sf ${PWD}/tmux-powerline ${HOME}/.config/tmux-powerline
