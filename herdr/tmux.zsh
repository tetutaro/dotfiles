export TERM="xterm-256color"
export FZF_TMUX=0
export FZF_COMMAND="fzf"

# each terminal attaches its own herdr session named <project>-<N>, because
# herdr keeps one focused workspace/tab per server: terminals sharing a
# session would always show the same tab (see README.md)

function __extract_project_from_pwd() {
    local -a new_prj ctp
    ctp=${PWD##$(echo ${PROJECT_TOP_DIR})}
    if [[ "${PWD}" == "${ctp}" ]]; then
        new_prj="default"
    else
        if [[ ${#${(ps:/:)ctp}} -lt ${PROJECT_DEPTH_FROM_TOP} ]]; then
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

# project of this shell: inside herdr it is the one of the session
# (panes do not inherit the launching shell's env)
() {
    local name
    name=$(__herdr_session_name)
    if [[ ${name} == *-<-> ]]; then
        typeset -g HERDR_PROJECT=${name%-*}
    else
        typeset -g HERDR_PROJECT=$(__extract_project_from_pwd)
    fi
}

# file through which a pane asks the launcher loop of its terminal to attach
# another session: it holds either the directory to move to (a session of
# its project is picked) or the name of the session
function __herdr_next_file() {
    print -r -- ${XDG_RUNTIME_DIR:-/tmp}/herdr-next-${UID}/${1}
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

## for compatible
# herdr has no API to detach a client, so send the detach key (prefix+d in
# herdr/config.toml) to the hsl tmux wrapping the client of this session.
# from a popup, send it after ${1} seconds: keys sent while the popup is open
# go to the popup instead of herdr
function __herdr_detach() {
    local name line
    name=$(__herdr_session_name) || return 1
    for line in ${(f)"$(__herdr_hsl_clients)"}; do
        [[ ${line#* } == ${name} ]] || continue
        if [[ -n ${1} ]]; then
            # outlive the popup being closed: fork into a new session before
            # returning (a background job is killed with the popup)
            setsid -f zsh -c 'sleep "$1"; tmux -L "$2" send-keys C-Space d' \
                zsh ${1} ${line%% *} &>/dev/null < /dev/null
        else
            tmux -L ${line%% *} send-keys C-Space d
        fi
        return 0
    done
    return 1
}

# exiting the last pane of the session closes the terminal: remove the
# session if the project has another one, else keep it and only detach
function exit() {
    if [[ ${HERDR_ENV} == 1 ]]; then
        local name cnt
        name=$(__herdr_session_name)
        cnt=$(herdr workspace list 2>/dev/null \
            | jq -r '[.result.workspaces[].pane_count] | add' 2>/dev/null)
        if [[ -n ${name} && ${cnt} == 1 ]]; then
            cnt=$(herdr session list --json 2>/dev/null \
                | jq -r --arg p "${HERDR_PROJECT}" \
                '[.sessions[].name | select(startswith($p + "-") and (ltrimstr($p + "-") | test("^[0-9]+$")))] | length')
            if (( cnt >= 2 )); then
                # outlive the server being stopped: fork into a new session
                # before returning (see __herdr_detach)
                setsid -f zsh -c '
                    herdr session stop "$1"
                    for i in {1..50}; do
                        herdr session delete "$1" && break
                        sleep 0.1
                    done' zsh ${name} &>/dev/null < /dev/null
                return 0
            fi
            __herdr_detach && return 0
            print -u2 -- "last pane of session '${name}': detach with prefix+d, or use force-exit"
            return 1
        fi
    fi
    builtin exit
}

function force-exit() {
    builtin exit
}

# move this terminal to ${1}: a directory (a session of its project) or a
# session name; this session is left for another terminal
# ${2}: delay of the detach (see __herdr_detach)
function __herdr_switch_to() {
    local name next
    name=$(__herdr_session_name) || return 1
    next=$(__herdr_next_file ${name})
    mkdir -p ${next:h}
    print -r -- ${1} > ${next}
    __herdr_detach ${2} && return 0
    rm -f ${next}
    return 1
}

# moving to another project moves this terminal to a session of that project
function __chpwd_switch_session() {
    # a cd in a subshell (e.g. "(cd dir && make)", "$(cd dir; pwd)") is temporary
    if [[ ${HERDR_ENV} != 1 ]] || (( ZSH_SUBSHELL > 0 )); then
        return 0
    fi
    local new_prj dir
    new_prj=$(__extract_project_from_pwd)
    if [[ "${new_prj}" != "${HERDR_PROJECT}" ]]; then
        dir=${PWD}
        # this pane stays in this session, so return it to where it was
        cd - &>/dev/null
        __herdr_switch_to ${dir}
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
# attach a session of the project of ${PWD} (like the tmux session group), and
# again whenever a pane asks to move to another project or session; close the
# terminal when the client ends otherwise
function __tmux_attach_session_group() {
    if [[ ${HERDR_ENV} == 1 ]]; then
        return 0
    fi
    local name next target
    while true; do
        [[ -n ${name} ]] || name=$(__herdr_pick_session $(__extract_project_from_pwd))
        next=$(__herdr_next_file ${name})
        rm -f ${next}
        if (( ${+commands[hsl]} )); then
            hsl --session ${name}
        else
            herdr --session ${name}
        fi
        [[ -f ${next} ]] || builtin exit
        target=$(<${next})
        rm -f ${next}
        if [[ ${target} == /* ]]; then
            cd "${target}" || builtin exit
            name=
        else
            name=${target}
        fi
    done
}
