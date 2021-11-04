# install and setup powerline

## Why I use [powerline](https://github.com/powerline/powerline)

There are many applications that make statusline/prompt looks good.

* shell prompt
    * [powerline-shell](https://github.com/b-ryan/powerline-shell)
* vim statusline
    * [vim-airline](https://github.com/vim-airline/vim-airline)
* tmux statusline
    * [tmux-powerline](https://github.com/erikw/tmux-powerline)

But I decided to use [powerline](https://github.com/powerline/powerline).  The reasons are

* I want to make all of these (shell, vim, tmux) looks good
* I want to set up all of these at once and almost the same
* I want to have just one server that inquires about the information to be displayed
* I want to create original widget. So I want the application to be implemented in Python

## Necessities

* pipx
    * pipx is installed in [zsh](/zsh/)

## What this does

* install powerline (powerline-status) with pipx (if it has not been installed)
* install original widgets of powerline
* create symbolic links of powerline bindings and powerline vim plugin
    * `${POWERLINE_ROOT}/powerline/bindings` -> `~/.local/share/powerline-bindings`
    * `${POWERLINE_ROOT}/powerline/bindings/vim` -> `~/.vim/plugged/powerline.vim`
* create and overwrite symbolic links of config files
    * `prompt.zsh` -> `~/.config/zsh/prompt.zsh` (overwrite)
    * `plugins.vim` -> `~/.vim/plugins.vim` (overwrite)
    * `status.conf` -> `~/.config/tmux/status.conf` (overwrite)
    * `config.json` -> `~/.config/powerline/config.json`
    * `colors.json` -> `~/.config/powerline/colors.json`
    * `themes` -> `~/.config/powerline/themes`
    * `colorschemes` -> `~/.config/powerline/colorschemes`

## What to do

* `> ./install.sh`
* `> vim -c PlugInstall -c quit -c quit`

## When you want to stop using powerline

* go to [zsh](/zsh/) and `> ./install.sh`
    * re-overwrite `~/.config/zsh/prompt.zsh`
* go to [vim](/vim/) and `> ./install.sh`
    * re-overwrite `~/.vim/plugins.vim`
* go to [tmux](/tmux/) and `> ./install.sh`
    * re-overwrite `~/.config/tmux/status.conf`

## Contents of each config file

* `prompt.zsh`
    * configuration of zsh to use powerline in zsh
* `plugins.vim`
    * configuration of vim to use powerline in vim instead of vim-airline
* `status.conf`
    * configuration of tmux to use powerline in tmux
* `config.json`
    * basic configuration of powerline
* `colors.json`
    * color definitions in powerline
    * this will be replaced by [color_scheme](/color_scheme/) (if you use)
* `themes`
    * configurations of powerline theme
        * widgets you use in each application
        * location, size and additional information of each widgets
* `colorschemes`
    * configurations of powerline colorscheme
        * colors of each widget

## Original widgets (powerline segments)

* `powerline_widgets.shell.poetry_virtualenv`
    * display shortened Python venv names
        * poetry automatically creates venv which has very long name
    * same as `powerline.segments.common.env.virtualenv` except above
* `powerline_widgets.shell.project_cwd`
    * if you in the project directory, display dirs from project directory
    * shoten dirs effectively
    * same as `powerline.segments.common.env.cwd` except above
