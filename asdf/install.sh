#!/usr/bin/bash

os=$(uname -s)

cd ${HOME}

# asdf itself
if [[ ! -d "${HOME}/.asdf" ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
    . "${HOME}/.asdf/asdf.sh"
fi

# fzf
if [[ ! -d "${HOME}/.asdf/installs/fzf" ]]; then
    asdf plugin add fzf https://github.com/kompiro/asdf-fzf.git
    asdf install fzf latest
    asdf global fzf latest
    .asdf/installs/fzf/$(asdf current fzf | sed -e "s/ \+/\t/g" | cut -f2)/install --xdg --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

# ag (the silver searcher)
# cannot compile latest ag so use apt
#if [[ ! -d "${HOME}/.asdf/installs/ag" ]]; then
#    if [[ "${os}" == "Linux" ]]; then
#        sudo apt build-dep silverseacher-ag
#        sudo apt install -y libpcre3-dev
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
fi

# xsel
if [[ "${os}" == "Linux" ]]; then
    if [[ -z $(command -v xsel) ]]; then
        sudo apt install -y xsel
    fi
fi

# tmux
if [[ -z $(command -v tmux) ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install -y bison
    else
        brew install utf8proc
    fi
    asdf plugin add tmux https://github.com/aphecetche/asdf-tmux.git
    if [[ "${os}" == "Linux" ]]; then
        asdf install tmux latest
    else
        asdf install tmux latest --enable-utf8proc
    fi
    asdf global tmux latest
fi

# vim
# cannot enable clipboard support so use apt
#if [[ ! -d "${HOME}/.asdf/installs/vim" ]]; then
#    if [[ "${os}" == "Linux" ]]; then
#        sudo apt build-dep vim-gtk3
#    else
#        brew installl ncurses
#    fi
#    export ASDF_VIM_CONFIG="--with-tlib=ncurses --with-compiledby=asdf --enable-multibyte --enable-cscope --enable-terminal --enable-perlinterp --enable-rubyinterp --enable-python3interp --enable-luainterp --enable-gui=gtk4 --with-x"
#    asdf plugin-add vim https://github.com/tsuyoshicho/asdf-vim.git
#    asdf install vim latest
#    asdf global vim latest
#fi
if [[ -z $(command -v vim) ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install -y vim-gtk3
    else
        brew install vim
    fi
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
fi

# typescript-language-server
if [[ -z $(command -v typescript-language-server) ]]; then
    yarn global add typescript typescript-language-server
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
    pipx ensurepath
fi

# golang
if [[ -z $(command -v go) ]]; then
    asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
    asdf install golang latest
    asdf global golang latest
fi

# rust
export RUST_WITHOUT=rust-docs,rust-other-component
if [[ -z $(command -v rustc) ]]; then
    asdf plugin add rust https://github.com/asdf-community/asdf-rust.git
    asdf install rust latest
    asdf global rust latest
fi

# direnv
if [[ ! -d "${HOME}/.asdf/installs/direnv" ]]; then
    asdf plugin add direnv
    asdf direnv setup --shell zsh --version latest
    asdf global direnv latest
fi

# tig
if [[ -z $(command -v tig) ]]; then
    asdf plugin add tig https://github.com/koketani/asdf-tig.git
    asdf install tig latest
    asdf global tig latest
fi

# git-open
if [[ -z $(command -v git-open) ]]; then
    asdf plugin add git-open https://github.com/tetutaro/asdf-git-open.git
    asdf install git-open latest
    asdf global git-open latest
fi

# docker
if [[ -z $(command -v docker) ]]; then
    if [[ "${os}" == "Linux" ]]; then
        sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    fi
fi

cd -
