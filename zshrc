##########################################################################
## path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:.
export MANPATH=/usr/share/man:/usr/local/share/man
##########################################################################
## locale
if [[ ${UID} = 0 ]]; then
    export LANG=C
else
    export LANG=ja_JP.UTF-8
fi
export LC_ALL=ja_JP.UTF-8
export LC_COLLATE=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_MESSAGES=ja_JP.UTF-8
export LC_MONETARY=ja_JP.UTF-8
export LC_NUMERIC=ja_JP.UTF-8
export LC_TIME=ja_JP.UTF-8
export LESSCHARSET=UTF-8
##########################################################################
## aliases
alias rm="rm -i"
alias mv="mv -i"
alias du="du -h"
alias df="df -H"
alias man="man -a"
alias tree="tree -NCF"
alias pipj="pipx runpip jupyterlab"
alias gd="dirs -v;echo -n 'select number: ';read newdir;cd $newdir"
##########################################################################
## OS dependencies
os=$(uname -s)
if [[ ${os} == "Linux" ]]; then
    export SHELL=/bin/zsh
    alias ls="ls --color -Fv"
    alias ll="ls --color -AFhlv"
    alias pbcopy="xsel --input --clipboard"
    alias pbpaste="xsel --output --clipboard"
    alias open="xdg-open"
elif [[ ${os} == "Darwin" ]]; then
    export SHELL=/usr/local/bin/zsh
    alias ls="ls -FGv"
    alias ll="ls -AFGhlov"
    alias l@="ls -@1AFGhloTv"
    alias zcat=gzcat
    alias cat4tab="cat $@ | sed -e \"s|"$'\t'"|    |g\""
    if [[ ${TERM} == "xterm-16color" ]]; then
        alias vi='/usr/local/bin/vim -u $HOME/.vim/defaults.vim "$@"'
    else
        alias vi='/usr/local/bin/vim -u $HOME/.vim/vimrc "$@"'
    fi
fi
##########################################################################
## key bindings
bindkey -d
bindkey -e
bindkey -r "^T"
bindkey -r "^O"
##########################################################################
## functions
## cdp
PROJECT_DIR="${HOME}/Projects"
function cdp() {
    if [[ -z "$1" ]]; then
        test "${PWD}" != "${PROJECT_DIR}" && pushd "${PROJECT_DIR}" > /dev/null
        local dir=$(command find -L . -type d -mindepth 2 -maxdepth 3 \( -path '*/.*' -or -path '*/__pycache__' \) -prune -or -type d -print 2>/dev/null | cut -b3- | fzf --preview 'tree -C {} | head -100' --preview-window down:50%:wrap:hidden --bind '?:toggle-preview')
        if [[ "${dir}" != "" ]]; then
            pushd "${dir}" > /dev/null
        fi
        unset dir
    else
        pushd "${PROJECT_DIR}/$1" > /dev/null
    fi
}
##########################################################################
## resource limits
limit coredumpsize 0
##########################################################################
## options
## Changing Directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_to_home
## Completion
setopt auto_name_dirs
setopt complete_aliases
setopt glob_complete
setopt no_list_beep
## Expansion and Globbing
setopt brace_ccl
setopt equals
setopt mark_dirs
setopt numeric_glob_sort
## History
setopt no_hist_beep
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
#setopt share_history
## Input/Output
setopt correct
setopt no_flow_control
setopt ignore_eof
setopt no_hash_cmds
setopt no_hash_dirs
setopt print_eight_bit
setopt short_loops
## Job Control
setopt auto_resume
setopt no_hup
setopt long_list_jobs
## Prompting
setopt prompt_subst
## Scripts and Functions
setopt multios
##########################################################################
## history
HISTFILE=${HOME}/.zsh_histroy
HISTSIZE=4096
SAVEHIST=4096
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
##########################################################################
## prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
autoload -Uz colors
colors
autoload -Uz add-zsh-hook
local p_rhst=""
#if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
#   local rhost=`who am i | sed 's/.*(\(.*\)).*/\1/'`
#   rhost=${rhost#localhost:}
#   rhost=${rhost%%.*}
#   p_rhst="%B%F{yellow}($rhost)%f%b"
#fi
local p_cdir="%B%F{blue}[%(5~|.../%2~|%~)]%f%b"$'\n'
local p_info="%n@%m${WINDOW:+[${WINDOW}]}"
local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"
local p_base=" $p_cdir$p_rhost$p_info $p_mark "
function __precmd_virtual_env() {
    local p_penv="%B%F{cyan}${VIRTUAL_ENV:+(`echo ${VIRTUAL_ENV##*/}|rev|cut -d- -f3-|rev`)}%f%b"
    PROMPT="$p_penv$p_base"
}
PROMPT2="(%_) %(!,#,>) "
SPROMPT="correct: %R -> %r ? [n,y,a,e]: "
#RPROMPT="%1(v|%1v|)%2(v| %B%F{yellow}%2v%f%b|)%3(v| %B%F{red}%3v%f%b|)"
add-zsh-hook precmd __precmd_virtual_env
##########################################################################
## completion
fpath=(${HOME}/.zcomp ${fpath} /usr/local/share/zsh-completions /usr/local/share/zsh/site-functions /usr/local/share/zsh/functions)
autoload -Uz compinit
compinit
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-dirs-first
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*:sudo:*' command-path /bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin .
##########################################################################
## prediction
#autoload -Uz predict-on
#predict-on
##########################################################################
## color settings
# frontemare
if [[ ${TERM} == "xterm-256color" ]] && [[ -f ~/.frontemare.sh ]]; then
    source ~/.frontemare.sh
fi
##########################################################################
## application settings
# fzf
if command -v fzf > /dev/null; then
    export FZF_COMPLETION_TRIGGER="@"
    # fzf & frontemare
    if [[ -f ~/.fzf.zsh ]]; then
        source ~/.fzf.zsh
    fi
    export FZF_ALT_C_COMMAND="find -L . -mindepth 1 -maxdepth 3 \( -path '*/.*' -o -path '*Library*' -o -path '*Applications*' -o -path '*Google Drive*' -o -path '*Dropbox*' -o -path '*VirtualBox VMs*' \) -prune -o -type d -print 2>/dev/null | cut -b3-"
    bindkey -r "^T"
    bindkey -r "\ec"
    bindkey "^X^F" fzf-file-widget
    bindkey "^X^D" fzf-cd-widget
fi
# nodenv
if [[ -d ${HOME}/.nodenv ]]; then
    export PATH=${HOME}/.nodenv/bin:${PATH}
    eval "$(nodenv init -)"
    if [[ ! -d ${HOME}/.pyenv ]]; then
        alias rehash="nodenv rehash; rehash"
    fi
fi
# pyenv
if [[ -d ${HOME}/.pyenv ]]; then
    export PYENV_ROOT=${HOME}/.pyenv
    export PATH=${PYENV_ROOT}/bin:${PATH}
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    if [[ -d ${HOME}/.nodenv ]]; then
        alias rehash="nodenv rehash; pyenv rehash; rehash"
    else
        alias rehash="pyenv rehash; rehash"
    fi
fi
# pyenv-virtualenv
if [[ -d ${HOME}/.pyenv/plugins/pyenv-virtualenv ]]; then
    eval "$(pyenv virtualenv-init -)"
fi
# poetry
if [[ -d ${HOME}/.poetry ]]; then
    export PATH=${HOME}/.poetry/bin:${PATH}
fi
# pipx
if [[ -d ${HOME}/.local/bin ]]; then
    export PATH=${PATH}:${HOME}/.local/bin
fi
##########################################################################
## include local settings
if [[ -f ~/.zshrc.include ]]; then
    source ~/.zshrc.include
fi
