export VIRTUAL_ENV_DISABLE_PROMPT=1
autoload -Uz colors
colors
autoload -Uz add-zsh-hook
#local p_rhst=""
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
