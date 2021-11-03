# frontarith
# Author: tetutaro

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
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=fg:$colorFG,bg:-1,hl:$colorF7,fg+:$colorFG,bg+:$colorBf,gutter:-1,hl+:$colorF7,prompt:$colorF6,pointer:$colorF4,marker:$colorF2,spinner:$colorF1,info:$colorF5"
}
_gen_fzf_default_opts