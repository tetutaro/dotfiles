# frontemare
# Author: tetutaro

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
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=fg:$colorFG,bg:-1,hl:$colorF7,fg+:$colorFG,bg+:$colorBf,gutter:-1,hl+:$colorF7,prompt:$colorF6,pointer:$colorF4,marker:$colorF2,spinner:$colorF1,info:$colorF5"
}
_gen_fzf_default_opts