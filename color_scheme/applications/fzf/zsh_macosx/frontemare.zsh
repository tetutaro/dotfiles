# frontemare
# Author: tetutaro

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
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# fzf + ag configuration
# ------------
export FZF_DEFAULT_COMMAND='ag --ignore "Library" --ignore "Applications" --ignore "Pictures" --ignore "Music" --ignore "Movies" --ignore "__pycache__" --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'head -100 {}' --preview-window down:50%:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.*' -or -fstype 'sysfs' -or -fstype 'devfs' -or -fstype 'devtmpfs' -or -fstype 'proc' -or -path '*/Library' -or -path '*/Applications' -or -path '*/Pictures' -or -path '*/Music' -or -path '*/Movies' -or -path '*/__pycache__' \\) -prune -or -type d -print 2>/dev/null | cut -b3-"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100' --preview-window down:50%:hidden:wrap --bind '?:toggle-preview'"

_gen_fzf_default_opts() {

local colorBG='#000000'
local colorBg='#11141a'
local colorBf='#212733'
local colorBF='#323b4d'
local colorFG='#c3cad9'
local colorFg='#959aa6'
local colorB1='#5a4266'
local colorB2='#665a42'
local colorB3='#42664e'
local colorB4='#424e66'
local colorB5='#424266'
local colorF1='#bf8dd8'
local colorF2='#cc9c84'
local colorF3='#bfbf7c'
local colorF4='#74b374'
local colorF5='#7cbfbf'
local colorF6='#95b0e6'
local colorF7='#9d9df2'

export FZF_DEFAULT_OPTS="\
    --color=fg:$colorFG,bg:-1,hl:$colorF7\
    --color=fg+:$colorFG,bg+:$colorB4,gutter:$colorBg,hl+:$colorF7\
    --color=prompt:$colorF6,pointer:$colorF4,marker:$colorF2\
    --color=spinner:$colorF1,info:$colorF5\
    --tac --cycle --layout=reverse --select-1 --exit-0\
"

}

_gen_fzf_default_opts
