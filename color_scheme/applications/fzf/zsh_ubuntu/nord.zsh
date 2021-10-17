# nord
# Author: arcticicestudio (https://www.nordtheme.com/)

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/doc/fzf/examples/key-bindings.zsh"

# fzf + ag configuration
# ------------
export FZF_DEFAULT_COMMAND='ag --ignore "Library" --ignore "Applications" --ignore "Pictures" --ignore "Music" --ignore "Movies" --ignore "__pycache__" --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'head -100 {}' --preview-window down:50%:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.*' -or -fstype 'sysfs' -or -fstype 'devfs' -or -fstype 'devtmpfs' -or -fstype 'proc' -or -path '*/Library' -or -path '*/Applications' -or -path '*/Pictures' -or -path '*/Music' -or -path '*/Movies' -or -path '*/__pycache__' \\) -prune -or -type d -print 2>/dev/null | cut -b3-"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100' --preview-window down:50%:hidden:wrap --bind '?:toggle-preview'"

_gen_fzf_default_opts() {

local colorBG='#2e3440'
local colorBg='#3b4252'
local colorBf='#434c5e'
local colorBF='#4c566a'
local colorFG='#eceff4'
local colorFg='#d8dee9'
local colorB1='#7a3e44'
local colorB2='#766646'
local colorB3='#525f46'
local colorB4='#2f4056'
local colorB5='#5a4756'
local colorF1='#bf616a'
local colorF2='#d08770'
local colorF3='#ebcb8b'
local colorF4='#a3be8c'
local colorF5='#88c0d0'
local colorF6='#5e81ac'
local colorF7='#b48ead'

export FZF_DEFAULT_OPTS="\
    --color=fg:$colorFG,bg:-1,hl:$colorF7\
    --color=fg+:$colorFG,bg+:$colorB4,gutter:$colorBg,hl+:$colorF7\
    --color=prompt:$colorF6,pointer:$colorF4,marker:$colorF2\
    --color=spinner:$colorF1,info:$colorF5\
    --tac --cycle --layout=reverse --select-1 --exit-0\
"

}

_gen_fzf_default_opts
