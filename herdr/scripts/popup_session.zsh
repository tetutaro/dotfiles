#!/usr/bin/env zsh
# switch this terminal to another herdr session (a terminal is a session)

# helpers (only builtin exit is used here: tmux.zsh overrides exit)
source ~/.config/zsh/tmux.zsh

rows=(${(f)"$(__herdr_session_rows)"})
# start on the row of the current session
cur=${rows[(i)*[[:space:]]current]}
(( cur > ${#rows} )) && cur=1
# --no-tac/--layout: list in the sorted order from the top whatever
# FZF_DEFAULT_OPTS says (it has --tac)
selected=$(print -rl -- ${rows} | column -t -s $'\t' \
    | fzf --no-tac --layout=reverse --header "Select Session" \
        --bind "load:pos(${cur})") || builtin exit 0
name=${${(z)selected}[1]}
state=${${(z)selected}[2]}
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
