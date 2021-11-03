# install and setup vim

## Nessecities

* yarn
    * install some version of Node.js
        * nodenv is installed in [zsh](/zsh/)
        * `> nodenv install --list` (list available versions of Node.js)
        * `> nodenv install x.x.x`
        * `> nodenv global x.x.x`
        * `> rehash`
    * install yarn with npm
        * `> npm install -g yarn`

## What this does

* create (or overwrite) symbolic links of config files
    * `vimrc` -> `~/.vim/vimrc`
    * `defaults.vim` -> `~/.vim/defaults.vim`
    * `plugins.vim` -> `~/.vim/plugins.vim`
    * `keymaps.vim` -> `~/.vim/keymaps.vim`
    * copy `colors.vim` to `~/.vim/colors.vim`
        * if it is not exists
* install vim (if it has not been installed)
* install [vim-plug](https://github.com/junegunn/vim-plug) and vim plugins (if they have not been installed)

## What to do

* `> ./install.sh`

## Contents of each config file

* `defaults.vim`
    * basic configuration of vim
* `plugins.vim`
    * load vim-plug
    * list vim plugins
    * configuration of [vim-airline](https://github.com/vim-airline/vim-airline)
    * this will be replaced by powerline (if you use [powerline](/powerline/))
* `keymaps.vim`
    * I use [vim-which-key](https://github.com/liuchengxu/vim-which-key) to achieve the similar behavior as [SpaceVim](https://spacevim.org/) and [SpaceEmacs](https://www.spacemacs.org/)
    * definitions of key-bindings of vim-which-key
* `colors.vim`
    * dummy file
    * this will be replaced by color_scheme (if you use [color_scheme](/color_scheme/))
* `vimrc`
    * load additional configurations (`~/.vim/*.vim`)
    * configurations of each plugin

## Concepts of configuration

* Do not split the window
    * If I want to split the window, do it with tmux
* Do not use the tab
    * Use the buffer
* Make the most of fzf
    * find a file, find a buffer, find a word, ...
* Optimize for Python and Markdown
