# install and setup tmux

## What this does

* install tmux (if it has not been installed)
* install tmux plugins (if they have not been installed)
    * tpm
    * tmux-copycat
    * tmux-sidebar
* create and overwrite symbolic links of config files
    * `tmux.zsh` -> `~/.config/zsh/tmux.zsh` (overwrite)
    * `tmux.conf` -> `~/.config/tmux/tmux.conf`
    * `copy.ubuntu.conf`/`copy.macosx.conf` -> `~/.config/tmux/copy.conf`
    * `status.conf` -> `~/.config/tmux/status.conf`
    * `style.conf` -> `~/.config/tmux/style.conf`

## What to do

* `> ./install.sh`

## When you want to stop using tmux

* go to [zsh](/zsh/) and `> ./install.sh`
    * re-overwrite `~/.config/zsh/tmux.zsh`

## Contents of each config file

* `tmux.conf`
    * basic configuration of tmux
    * read additional configuration (`~/.config/tmux/*.conf`)
    * configuration of plugins
* `copy.conf`
    * copy to the system clipboard
* `status.conf`
    * dummy file
    * this will be replaced by powerline (if you use [powerline](/powerline/))
* `style.conf`
    * color configuration for tmux-specific parts
    * this will be replaced by color_scheme (if you use [color_scheme](/color_scheme/))
* `tmux.zsh`
    * original zsh functions
    * automatically {create, detach} tmux sessions like pyenv
        * all you have to do is {go in, out of} the project directory

## Original zsh functions

### Concepts

* I don't want to create/detach tmux sessions by hand
* The tmux session should be tied to the project
* Like pyenv, I want to {create, detach} tmux sessions just by (going in, out of} the project directory
    * If I am in a directory other than the project directory, I am in the "default" project
        * ex) ~, /usr/local/bin, ...
* I want to actively reuse detached tmux sessions, but it is not good to have so much detached tmux sessions
* I'm a mess, so I don't split windows
    * if I want to do something different, I launch a new terminal
* Don't use the tmux session group
    * The tmux session group basically shares the same window
    * I want to use a different window for each tmux session

### Specs

* name of the tmux session: `[project_name]-X`
    * `X` is an integer starts with 0
* When you go in the project directory
    * If there is no detached tmux session
        * create new session
            * `X` is the smallest unused number
        * go back to the previous directory
        * switch to the new session
    * else
        * go back to the previous directory
        * attach the detached session which has smallest number
* When you out of the project directory
    * detach the tmux session
    * and create/attach the tmux session of another project
* When you exit from terminal
    * If there are multiple tmux sessions of the project
        * destroy the tmux session
    * else
        * detach the tmux session
