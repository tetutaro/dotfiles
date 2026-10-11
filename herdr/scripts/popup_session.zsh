#!/usr/bin/env zsh
# switch this terminal to another herdr session (a terminal is a session)

# helpers (only builtin exit is used here: tmux.zsh overrides exit)
source ~/.config/zsh/tmux.zsh

# symbol of the state of the AI agents (the same as the statusline)
typeset -A agent_marks=(
    blocked $'\e[1;91m▲\e[0m'
    working $'\e[1;94m▶\e[0m'
    done    $'\e[1;92m■\e[0m'
    idle    $'\e[1;38;5;19m●\e[0m'
    unknown $'\e[1;93m◆\e[0m'
    none    $'\e[1;38;5;19m▬\e[0m'
)

rows=(${(f)"$(__herdr_session_rows)"})
# start on the row of the current session
cur=${rows[(i)*[[:space:]]current]}
(( cur > ${#rows} )) && cur=1
# align the columns here: column -t would count the escapes of the symbols
w=0
for row in ${rows}; do
    (( ${#row%%$'\t'*} > w )) && w=${#row%%$'\t'*}
done
lines=()
for row in ${rows}; do
    f=("${(@ps:\t:)row}")
    lines+=("$(printf '%-*s  %s  %s' ${w} ${f[1]} \
        ${agent_marks[${f[2]}]:-${agent_marks[none]}} ${f[3]})")
done
# --no-tac/--layout: list in the sorted order from the top whatever
# FZF_DEFAULT_OPTS says (it has --tac)
selected=$(print -rl -- ${lines} \
    | fzf --ansi --no-tac --layout=reverse --header "Select Session" \
        --bind "load:pos(${cur})") || builtin exit 0
name=${${(z)selected}[1]}
state=${${(z)selected}[3]}
case ${state} in
    current)
        ;;
    attached)
        # attaching it would show the same tab in both terminals
        print -r -- "${name} is attached by another terminal"
        sleep 1
        ;;
    *)
        # switch after this popup is closed
        __herdr_switch_to ${name} 0.3
        ;;
esac
builtin exit 0
