# frontarith
# Author: tetutaro

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/doc/fzf/examples/key-bindings.bash"

# fzf + ag configuration
# ------------
export FZF_DEFAULT_COMMAND='ag --ignore "Library" --ignore "Applications" --ignore "Pictures" --ignore "Music" --ignore "Movies" --ignore "__pycache__" --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'head -100 {}' --preview-window down:50% --bind '?:toggle-preview'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:50% --bind '?:toggle-preview'"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.*' -or -fstype 'sysfs' -or -fstype 'devfs' -or -fstype 'devtmpfs' -or -fstype 'proc' -or -path '*/Library' -or -path '*/Applications' -or -path '*/Pictures' -or -path '*/Music' -or -path '*/Movies' -or -path '*/__pycache__' \\) -prune -or -type d -print 2>/dev/null | cut -b3-"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100' --preview-window down:50% --bind '?:toggle-preview'"

_gen_fzf_default_opts() {

local colorBG='#000000'
local colorBg='#11141a'
local colorBf='#212733'
local colorBF='#323b4d'
local colorFG='#b7becc'
local colorFg='#8a8f99'
local colorB1='#664542'
local colorB2='#5c6642'
local colorB3='#426653'
local colorB4='#424e66'
local colorB5='#614266'
local colorF1='#cb84b0'
local colorF2='#cc9585'
local colorF3='#c5cc85'
local colorF4='#88cc85'
local colorF5='#85ccbf'
local colorF6='#849ccb'
local colorF7='#a984cb'

export FZF_DEFAULT_OPTS="\
    --color=fg:$colorFG,bg:$colorBG,hl:$colorF7\
    --color=fg+:$colorFG,bg+:$colorB4,gutter:$colorBg,hl+:$colorF7\
    --color=prompt:$colorF6,pointer:$colorF4,marker:$colorF2\
    --color=spinner:$colorF1,info:$colorF5\
    --tac --cycle --layout=reverse --select-1 --exit-0\
"

}

_gen_fzf_default_opts
