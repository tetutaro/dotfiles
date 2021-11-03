# nord
# Author: arcticicestudio (https://www.nordtheme.com/)

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
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=fg:$colorFG,bg:-1,hl:$colorF7,fg+:$colorFG,bg+:$colorBf,gutter:-1,hl+:$colorF7,prompt:$colorF6,pointer:$colorF4,marker:$colorF2,spinner:$colorF1,info:$colorF5"
}
_gen_fzf_default_opts