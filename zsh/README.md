# install and setup zsh

## What this does

* install required applications (if they have not been installed)
    * fzf, silversearcher, tree, xsel (ubuntu only)
* install Python environments (if they have not been installed)
    * uv
* install Node.js environments (if they have not been installed)
    * nodenv, node-build, node-build-update-defs
* create (or overwrite) symbolic links of config files
    * `zshrc` -> `~/.zshrc`
    * config files referenced by zshrc
        * `prompt.zsh` -> `~/.config/zsh/prompt.zsh`
        * `tmux.zsh` -> `~/.config/zsh/tmux.zsh`
        * `fzf.zsh` -> `~/.config/zsh/fzf.zsh`
        * `cdp.zsh` -> `~/.config/zsh/cdp.zsh`
        * `anyenv.zsh` -> `~/.config/zsh/anyenv.zsh`
* install zsh (if it has not been installed)

## What to do

* `> ./install.sh`

## Contents of each config file

* `zshrc`
    * basic configuration of zsh
    * load additional configurations (`~/.config/zsh/*.zsh`)
    * load color configuration (if you use [color_scheme](/color_scheme/))
    * load local configuration (if you create `~/.config/zsh/local.zsh`)
* `prompt.zsh`
    * configuration of prompt
    * display shortened Python venv names
        * poetry automatically creates venv which has very long name
    * this will be replaced by [powerline](/powerline/) (if you use)
* `tmux.zsh`
    * dummy functions
    * this will be replaced by [tmux](/tmux/) (if you use)
* `fzf.zsh`
    * configuration of fzf
* `cdp.zsh`
    * definition of original function: `cdp`
* `anyenv.zsh`
    * configuration of pyenv, pyenv-virtualenv, poetry, nodenv
    * load initial function of pyenv, pyenv-virtualenv, nodenv
    * I don't use [anyenv](https://github.com/anyenv/anyenv)

## Original function: `cdp`

* required environment variables (these are set in zshrc)
    * `PROJECT_TOP_DIR`: the directory that contains project directories
    * `PROJECT_DEPTH_FROM_TOP`: how many levels below the top of each project directory

example)
```
~/Projects
├── business/
│   ├── 2020/
│   │   └── project-a/
│   └── 2021/
│        └── project-b/
└── personal/
    ├── private/
    │    └── project-c/
    └── public/
          └── project-d/
```
* `PROJECT_TOP_DIR` = ~/Projects
* `PROJECT_DEPTH_FROM_TOP` = 3

### spec of `cdp`

* `cdp [return]`
    * if you are under the each project directory
        * go to the top of the project directory
    * else
        * go to `PROJECT_TOP_DIR`
* `cdp xx[return]`
    * find the project directory using fzf with arguments as a query
    * and go
* `cdp [tab]`
    * find the project directory using fzf
    * and go
* `cdp xx[tab]`
    * find the project directory using fzf with arguments as a query
    * and go
