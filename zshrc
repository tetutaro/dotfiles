################################################################################
## path
export PYENV_ROOT="$HOME/.pyenv"
export PATH="${HOME}/.poetry/bin:${PYENV_ROOT}/bin:.:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:${HOME}/.local/bin"
export MANPATH="/usr/share/man:/usr/local/share/man"
################################################################################
## locale
if [[ ${UID} = 0 ]]; then
    export LANG=C
else
    export LANG=ja_JP.UTF-8
fi
export SHELL=/usr/local/bin/zsh
export LC_ALL=ja_JP.UTF-8
export LC_COLLATE=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_MESSAGES=ja_JP.UTF-8
export LC_MONETARY=ja_JP.UTF-8
export LC_NUMERIC=ja_JP.UTF-8
export LC_TIME=ja_JP.UTF-8
export LESSCHARSET=UTF-8
export FONTCONFIG_PATH=/usr/local/etc/fonts
## FRONTEMARE
if [[ $TERM == 'xterm-256color' ]] then
    [ -f ~/.frontemare.sh ] && source ~/.frontemare.sh
fi
################################################################################
## aliases
alias rm="rm -i"
alias mv="mv -i"
alias du="du -h"
alias df="df -H"
alias man="man -a"
alias gd="dirs -v;echo -n 'select number: ';read newdir;cd +$newdir"
alias ls="ls --color -Fv"
alias ll="ls --color -AFhlv"
alias pbcopy="xsel --input --clipboard"
alias pbpaste="xsel --output --clipboard"
alias open="xdg-open"
################################################################################
## functions
bindkey -d
bindkey -e
bindkey -r "^O"
## cdp
function cdp {
    if [ -z "$1" ]; then
        test "$PWD" != "$HOME/Projects" && pushd "$HOME/Projects" > /dev/null
        local dir
        dir=$(command find -L . -mindepth 1 \( -path '*/\.*' -or -path '*/__pycache__' \) -prune -or -type d -print 2>/dev/null | cut -b3- | fzf --preview 'tree -C {} | head -100' --preview-window down:50%:wrap:hidden --bind '?:toggle-preview') && cd "$dir"
    else
        pushd "$HOME/Projects/$1" > /dev/null
    fi
}
################################################################################
## resource limits
limit coredumpsize 0
################################################################################
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
################################################################################
## history
HISTFILE=${HOME}/.zsh_histroy
HISTSIZE=4096
SAVEHIST=4096
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
################################################################################
## prompt
autoload colors
colors
local p_rhst=""
#if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
#    local rhost=`who am i | sed 's/.*(\(.*\)).*/\1/'`
#    rhost=${rhost#localhost:}
#    rhost=${rhost%%.*}
#    p_rhst="%B%F{yellow}($rhost)%f%b"
#fi
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'
local p_info="%n@%m${WINDOW:+"[$WINDOW]"}"
local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"
PROMPT=" $p_cdir$p_rhst$p_info $p_mark "
PROMPT2="(%_) %(!,#,>) "
SPROMPT="correct: %R -> %r ? [n,y,a,e]: "
#RPROMPT="%1(v|%1v|)%2(v| %B%F{yellow}%2v%f%b|)%3(v| %B%F{red}%3v%f%b|)"
################################################################################
## completion
fpath=(${HOME}/.zcomp ${fpath} /usr/local/share/zsh-completions /usr/local/share/zsh/site-functions)
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
zstyle ':completion:*:sudo:*' command-path /bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin $HOME/bin .
################################################################################
## prediction
#autoload predict-on
#predict-on
################################################################################
## application settings
# fzf
export FZF_COMPLETION_TRIGGER='@'
# fzf & frontemare
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
# pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"
################################################################################
## include local settings
if [[ -f ~/.zshrc.include ]]; then
    source ~/.zshrc.include
fi
