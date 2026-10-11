#!/usr/bin/env zsh
# browse every herdr session as a tree of its workspaces, tabs and panes:
# move this terminal to the selected one (enter) or delete its session (x)
# --rows: print the rows of the tree (for reloading fzf)
# --delete <session>: delete the session and print the fzf actions to follow

# helpers (only builtin exit is used here: tmux.zsh overrides exit)
source ~/.config/zsh/tmux.zsh

self=${0:A}

# "<running>\t<socket path>" of session ${1} (empty if it does not exist)
function session_info() {
    herdr session list --json 2>/dev/null | jq -r --arg n "${1}" \
        '.sessions[] | select(.name == $n) | "\(.running)\t\(.socket_path)"'
}

# state of session ${1} now (see __herdr_session_state)
function session_state() {
    local running sock
    IFS=$'\t' read -r running sock <<< "$(session_info ${1})"
    [[ -n ${running} ]] || return 1
    __herdr_session_state ${1} ${running} "$(__herdr_session_name)" \
        ${${(f)"$(__herdr_hsl_clients)"}#* }
}

# delete session ${1} unless a terminal shows it (deleting it would close
# that terminal), then print the fzf actions to show the result
function delete_session() {
    local name=${1} state msg i
    state=$(session_state ${name})
    case ${state} in
        current|attached)
            print -r -- "change-footer:${name} is ${state}: not deleted"
            return 0
            ;;
        detached)
            __herdr_stop_session ${name} delete
            ;;
        stopped)
            herdr session delete ${name} &>/dev/null
            ;;
    esac
    # the stop and delete run in the background: wait for them
    for i in {1..50}; do
        [[ -z $(session_info ${name}) ]] && break
        sleep 0.1
    done
    if [[ -n $(session_info ${name}) ]]; then
        msg="could not delete ${name}"
    else
        msg="deleted ${name}"
    fi
    print -r -- "reload(${(q)self} --rows)+change-footer:${msg}"
}

# show session ${1} in this terminal, focusing workspace ${2}, tab ${3} and
# agent pane ${4} of it (each if not empty)
function go_to() {
    local name=${1} wid=${2} tid=${3} pid=${4} state running sock
    state=$(session_state ${name}) || return 1
    if [[ ${state} == attached ]]; then
        # attaching it would show the same tab in both terminals
        print -r -- "${name} is attached by another terminal"
        sleep 1
        return 0
    fi
    IFS=$'\t' read -r running sock <<< "$(session_info ${name})"
    # the focus belongs to the server: set it before showing the session
    if [[ ${running} == true ]]; then
        [[ -n ${wid} ]] && HERDR_SOCKET_PATH=${sock} herdr workspace focus ${wid} &>/dev/null
        [[ -n ${tid} ]] && HERDR_SOCKET_PATH=${sock} herdr tab focus ${tid} &>/dev/null
        [[ -n ${pid} ]] && HERDR_SOCKET_PATH=${sock} herdr agent focus ${pid} &>/dev/null
    fi
    # switch after this popup is closed
    [[ ${state} == current ]] || __herdr_switch_to ${name} 0.3
}

case ${1} in
    --rows)
        __herdr_tree_rows
        builtin exit 0
        ;;
    --delete)
        delete_session ${2}
        builtin exit 0
        ;;
esac

rows=(${(f)"$(__herdr_tree_rows)"})
# start on the row of the current session
cur=1
for (( i = 1; i <= ${#rows}; i++ )); do
    if [[ ${rows[i]} == *$'\t'session$'\t'*'  current' ]]; then
        cur=${i}
        break
    fi
done
# --no-tac/--layout: list in the tree order from the top whatever
# FZF_DEFAULT_OPTS says (it has --tac); unbind(load): stay on the row after
# a reload (--track)
selected=$(print -rl -- ${rows} \
    | fzf --ansi --no-tac --layout=reverse --no-input --no-sort --track \
        --delimiter $'\t' --with-nth 6 \
        --header 'j/k: move  enter: go  x: delete session  esc: quit' \
        --bind "load:pos(${cur})+unbind(load)" \
        --bind 'j:down,k:up' \
        --bind "x:transform:${(q)self} --delete {1}") || builtin exit 0
f=("${(@ps:\t:)selected}")
go_to "${f[1]}" "${f[3]}" "${f[4]}" "${f[5]}"
builtin exit 0
