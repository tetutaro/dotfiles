export TERM="xterm-256color"
export FZF_TMUX=0
export FZF_COMMAND="fzf"

## for comapible
function force-exit() {
    builtin exit
}

## dummy function
function __tmux_attach_session_group() {
}
