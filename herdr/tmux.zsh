export TERM="xterm-256color"
export FZF_TMUX=0
export FZF_COMMAND="fzf"

# each terminal attaches its own herdr session named <project>-<N>, because
# herdr keeps one focused workspace/tab per server: terminals sharing a
# session would always show the same tab (see README.md)

function __extract_project_from_pwd() {
    local -a new_prj ctp
    # compare with a trailing slash so that siblings like ~/Projects-old
    # are not taken as being under ${PROJECT_TOP_DIR}
    ctp=${PWD#${PROJECT_TOP_DIR}/}
    if [[ "${PWD}" == "${ctp}" ]]; then
        new_prj="default"
    else
        if [[ ${(w)#${(ps:/:)ctp}} -lt ${PROJECT_DEPTH_FROM_TOP} ]]; then
            new_prj="default"
        else
            new_prj=${${(s:/:)ctp}[(w)${PROJECT_DEPTH_FROM_TOP}]}
        fi
    fi
    print -r -- ${new_prj}
}

# name of the herdr session this pane runs in (fails outside a named session)
function __herdr_session_name() {
    [[ ${HERDR_SOCKET_PATH} == */sessions/*/herdr.sock ]] || return 1
    print -r -- ${${HERDR_SOCKET_PATH%/herdr.sock}##*/}
}

# directory of project ${1} (${HOME} for default; fails if not found)
function __project_dir() {
    local pat
    local -a dirs
    if [[ ${1} == default ]]; then
        print -r -- ${HOME}
        return 0
    fi
    # ${PROJECT_TOP_DIR}/*/${1} for the depth 2
    pat=${(l:$(( (PROJECT_DEPTH_FROM_TOP - 1) * 2 ))::*/:)}
    dirs=(${PROJECT_TOP_DIR}/${~pat}${1}(N/))
    (( ${#dirs} )) || return 1
    print -r -- ${dirs[1]}
}

# project of this shell: inside herdr it is the one of the session
# (panes do not inherit the launching shell's env)
() {
    local name dir
    name=$(__herdr_session_name)
    if [[ ${name} == *-<-> ]]; then
        typeset -g HERDR_PROJECT=${name%-*}
        # a pane may start outside the project of its session, e.g. the one
        # herdr respawns in ${HOME} after the last pane died: move it there
        # (-q: the chpwd hook would move the terminal to another session)
        if [[ $(__extract_project_from_pwd) != ${HERDR_PROJECT} ]]; then
            dir=$(__project_dir ${HERDR_PROJECT}) && cd -q ${dir}
        fi
    else
        typeset -g HERDR_PROJECT=$(__extract_project_from_pwd)
    fi
}

# print "<hsl tmux socket name> <herdr session>" of every terminal attached
# now (hsl wraps each herdr client in its own tmux server)
function __herdr_hsl_clients() {
    local s env
    for s in ${TMUX_TMPDIR:-/tmp}/tmux-${UID}/hsl-*(N=); do
        s=${s:t}
        [[ -n $(tmux -L ${s} list-clients 2>/dev/null) ]] || continue
        env=$(tmux -L ${s} show-environment -g HERDR_SESSION 2>/dev/null) || continue
        print -r -- "${s} ${env#HERDR_SESSION=}"
    done
}

# session for a new terminal of project ${1}: the smallest existing one that
# no terminal attaches, else a new one with the smallest unused number
function __herdr_pick_session() {
    local prj=${1} name n
    local -a attached existing idle
    attached=(${${(f)"$(__herdr_hsl_clients)"}#* })
    existing=(${(f)"$(herdr session list --json 2>/dev/null | jq -r '.sessions[].name')"})
    for name in ${existing}; do
        [[ ${name} == ${prj}-<-> ]] || continue
        (( ${attached[(Ie)${name}]} )) && continue
        idle+=(${name##*-})
    done
    if (( ${#idle} )); then
        print -r -- ${prj}-${${(on)idle}[1]}
        return 0
    fi
    n=1
    while (( ${existing[(Ie)${prj}-${n}]} )); do
        (( n++ ))
    done
    print -r -- ${prj}-${n}
}

# print "<session>\t<state>" of every <project>-<N> session sorted by
# project and number, where state is current (this terminal), attached
# (another terminal), detached or stopped
function __herdr_session_rows() {
    local cur name state running
    local -a attached
    cur=$(__herdr_session_name)
    attached=(${${(f)"$(__herdr_hsl_clients)"}#* })
    herdr session list --json 2>/dev/null \
        | jq -r '.sessions[] | "\(.name)\t\(.running)"' \
        | while IFS=$'\t' read -r name running; do
            # only sessions of terminals (not e.g. herdr's own "default")
            [[ ${name} == *-<-> ]] || continue
            if [[ ${name} == ${cur} ]]; then
                state=current
            elif (( ${attached[(Ie)${name}]} )); then
                state=attached
            elif [[ ${running} == true ]]; then
                state=detached
            else
                state=stopped
            fi
            print -r -- "${name}"$'\t'"${state}"
        done | sort -t $'\t' -k1,1V
}

# stop session ${1} and delete it if ${2} is "delete", in the background.
# the job must outlive this shell, the herdr server and the terminal, which
# all end with the stop (the terminal closes with its herdr client): a job of
# this shell stays in the cgroup of the terminal (e.g. the systemd scope of a
# ghostty surface) and in the session of the pane, and is killed with them.
# so run it as a transient service of the user manager (output in the journal:
# journalctl --user -u 'herdr-stop-*'), else at least in its own session
function __herdr_stop_session() {
    local herdr=${commands[herdr]} script
    [[ -n ${herdr} ]] || return 1
    # delete refuses a session until its server has stopped
    script='
        "$1" session stop "$2"
        [[ $3 == delete ]] || exit 0
        for i in {1..100}; do
            "$1" session delete "$2" && exit 0
            sleep 0.1
        done
        exit 1'
    # the herdr of mise is not in the PATH of the user manager: pass its path
    if (( ${+commands[systemd-run]} )) && systemd-run --user --collect --quiet \
        --unit=herdr-stop-$$-${RANDOM} --description="stop herdr session ${1}" \
        ${commands[zsh]:-zsh} -c ${script} zsh ${herdr} ${1} "${2}" &>/dev/null; then
        return 0
    fi
    (( ${+commands[setsid]} )) || return 1
    setsid -f nohup zsh -c ${script} zsh ${herdr} ${1} "${2}" &>/dev/null < /dev/null
}

# exiting the last pane of the session closes the terminal: stop the session,
# and remove it if the project has another one (else it is resumed by the
# next terminal of the project, see __herdr_pick_session).
# only for the interactive shell itself: not in subshells ("(... || exit 1)")
# nor in non-interactive shells importing this function (e.g. the shell
# snapshot of an AI agent running in a pane)
function exit() {
    if [[ ${HERDR_ENV} == 1 && -o interactive ]] && (( ZSH_SUBSHELL == 0 )); then
        local name cnt mode
        name=$(__herdr_session_name)
        cnt=$(herdr workspace list 2>/dev/null \
            | jq -r '[.result.workspaces[].pane_count] | add' 2>/dev/null)
        if [[ -n ${name} && ${cnt} == 1 ]]; then
            cnt=$(herdr session list --json 2>/dev/null \
                | jq -r --arg p "${HERDR_PROJECT}" \
                '[.sessions[].name | select(startswith($p + "-") and (ltrimstr($p + "-") | test("^[0-9]+$")))] | length')
            (( cnt >= 2 )) && mode=delete
            __herdr_stop_session ${name} ${mode} && return 0
            print -u2 -- "last pane of session '${name}': detach with prefix+d, or use force-exit"
            return 1
        fi
    fi
    builtin exit "$@"
}

# stop and delete the session of this terminal whatever the panes and the
# other sessions of the project are, which closes the terminal (outside
# herdr, or if it cannot be stopped, just exit the shell)
function force-exit() {
    if [[ ${HERDR_ENV} == 1 && -o interactive ]] && (( ZSH_SUBSHELL == 0 )); then
        local name
        name=$(__herdr_session_name)
        if [[ ${name} == *-<-> ]] && __herdr_stop_session ${name} delete; then
            return 0
        fi
    fi
    builtin exit "$@"
}

# move this terminal to ${1}: a directory (a session of its project) or a
# session name; this session is left for another terminal.
# replace the herdr client in the hsl tmux of this terminal with a client of
# the other session: everything goes through tmux, nothing through files
# ${2}: delay of the switch in seconds, for a popup: the hsl tmux waits for
# it on its own, so that the switch outlives the popup being closed
function __herdr_switch_to() {
    local name line sock next dir
    local -a panes respawn setenv
    name=$(__herdr_session_name) || return 1
    (( ${+commands[herdr]} )) || return 1
    for line in ${(f)"$(__herdr_hsl_clients)"}; do
        [[ ${line#* } == ${name} ]] || continue
        sock=${line%% *}
        break
    done
    [[ -n ${sock} ]] || return 1
    panes=(${(f)"$(tmux -L ${sock} list-panes -a -F '#{pane_id}' 2>/dev/null)"})
    (( ${#panes} )) || return 1
    if [[ ${1} == /* ]]; then
        next=$(__herdr_pick_session $(PWD=${1} __extract_project_from_pwd))
        dir=${1}
    else
        next=${1}
        dir=$(__project_dir ${next%-*}) || dir=${HOME}
    fi
    [[ -n ${next} && ${next} != ${name} ]] || return 1
    # -k ends the current client like closing the terminal does, which leaves
    # this session running; HERDR_SESSION tells which session the terminal
    # shows (see __herdr_hsl_clients), set only once the respawn succeeded
    respawn=(respawn-pane -k -t ${panes[1]} -c ${dir}
        "exec ${(q)commands[herdr]} --session ${(q)next}")
    setenv=(set-environment -g HERDR_SESSION ${next})
    if [[ -n ${2} ]]; then
        tmux -L ${sock} run-shell -b -d ${2} -C \
            "${(j: :)${(@qq)respawn}} ; ${(j: :)${(@qq)setenv}}" &>/dev/null || return 1
    else
        tmux -L ${sock} ${respawn} \; ${setenv} &>/dev/null || return 1
    fi
    return 0
}

# moving to another project moves this terminal to a session of that project
function __chpwd_switch_session() {
    # a cd in a subshell (e.g. "(cd dir && make)", "$(cd dir; pwd)") is temporary
    if [[ ${HERDR_ENV} != 1 ]] || (( ZSH_SUBSHELL > 0 )); then
        return 0
    fi
    local new_prj
    new_prj=$(__extract_project_from_pwd)
    if [[ "${new_prj}" != "${HERDR_PROJECT}" ]]; then
        if __herdr_switch_to ${PWD}; then
            # this pane stays in this session, so return it to where it was
            # (-q: without running this hook again)
            cd -q - &>/dev/null
        else
            print -u2 -- "could not switch to a session of '${new_prj}': staying in '${HERDR_PROJECT}'"
        fi
    fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd __chpwd_switch_session

# label the workspace/tab of a fresh session <project>/<N> (herdr labels
# them after the cwd), as shown by the status line
function __herdr_adopt_session() {
    [[ ${HERDR_ENV} == 1 ]] || return 0
    local name wid tid
    name=$(__herdr_session_name) || return 0
    [[ ${name} == *-<-> ]] || return 0
    # only the root pane of a fresh session (not splits / new tabs)
    wid=$(herdr workspace list 2>/dev/null | jq -r '.result.workspaces
        | select(length == 1) | .[0]
        | select(.tab_count == 1 and .pane_count == 1) | .workspace_id' 2>/dev/null)
    [[ -n ${wid} ]] || return 0
    tid=$(herdr tab list --workspace ${wid} 2>/dev/null \
        | jq -r '.result.tabs[0].tab_id' 2>/dev/null)
    herdr workspace rename ${wid} ${name%-*} &>/dev/null
    [[ -n ${tid} ]] && herdr tab rename ${tid} ${name##*-} &>/dev/null
}
# run once at the first prompt: herdr is not in PATH yet while zshrc sources
# this file (mise is set up later), and in the background not to delay it
function __herdr_adopt_session_once() {
    add-zsh-hook -d precmd __herdr_adopt_session_once
    __herdr_adopt_session &!
}
add-zsh-hook precmd __herdr_adopt_session_once

# keep the function name used by zshrc
# attach a session of the project of ${PWD} (like the tmux session group);
# moving to another project or session happens inside hsl (see
# __herdr_switch_to), so the terminal closes when the client ends
function __tmux_attach_session_group() {
    if [[ ${HERDR_ENV} == 1 ]]; then
        return 0
    fi
    local name
    name=$(__herdr_pick_session $(__extract_project_from_pwd))
    if (( ${+commands[hsl]} )); then
        hsl --session ${name}
    else
        herdr --session ${name}
    fi
    builtin exit
}
