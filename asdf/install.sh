#!/usr/bin/bash

os=$(uname -s)

# asdf itself
if [[ ! -d "${HOME}/.asdf" ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
    . "${HOME}/.asdf/asdf.sh"
fi

# fzf
if [[ ! -d "${HOME}/.asdf/installs/fzf" ]]; then
    asdf plugin add fzf https://github.com/kompiro/asdf-fzf.git
    asdf install fzf latest
    FZF_VERSION=$(echo $(asdf list fzf) | tr -d ' ')
    .asdf/installs/fzf/${FZF_VERSION}/install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish
    asdf global fzf latest
fi

# ag (the silver searcher)
#if [[ ! -d "${HOME}/.asdf/installs/ag" ]]; then
#    if [[ "${os}" == "Linux" ]]; then
#        sudo apt install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
#    else
#        brew install automake pkg-config pcre xz
#    fi
#    asdf plugin add ag https://github.com/koketani/asdf-ag.git
#    asdf install ag latest
#    asdf global ag latest
#fi
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
else
    echo "tree is already installed"
fi

# xsel
if [[ "${os}" == "Linux" ]]; then
    if [[ -z $(command -v xsel) ]]; then
        sudo apt install -y xsel
    else
        echo "xsel is already installed"
    fi
fi

# tmux
if [[ ! -d "${HOME}/.asdf/installs/tmux" ]]; then
    asdf plugin-add tmux https://github.com/aphecetche/asdf-tmux.git
    asdf install tmux latest
    asdf global tmux latest
fi

# vim
if [[ ! -d "${HOME}/.asdf/installs/vim" ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install -y ncurses-dev
    else
        brew installl ncurses
    fi
    asdf plugin-add vim https://github.com/tsuyoshicho/asdf-vim.git
    asdf install vim latest
    asdf global vim latest
fi

# nodejs
if [[ ! -d "${HOME}/.asdf/installs/nodejs" ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install -y dirmngr gpg curl gawk
    else
        brew install gpg gawk
    fi
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    asdf install nodejs latest
    asdf global nodejs latest
fi

# yarn
if [[ -z $(command -v yarn) ]]; then
    npm install -g yarn
    rehash
fi

# typescript-language-server
if [[ -z $(command -v typescript-language-server) ]]; then
    yarn add global typescript typescript-language-server
    rehash
fi

# uv
if [[ ! -d "${HOME}/.asdf/installs/uv" ]]; then
    asdf plugin add uv https://github.com/b1-luettje/asdf-uv.git
    asdf install uv latest
    asdf global uv latest
    uv python install 3.11.10
fi

# pipx
if [[ -z $(command -v pipx) ]]; then
    uv tool install pipx
fi
