export FZF_TMUX=1
export FZF_COMMAND="fzf-tmux"

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

export TMUX_SESSION_GROUP=$(__extract_project_from_pwd)

function exit() {
    local -a cnt_s
    if [[ ! -z ${TMUX} ]]; then
        cnt_s=$(tmux list-sessions -F '#{session_name}' | grep -e "^${TMUX_SESSION_GROUP}-" | wc -l)
        if [[ ${cnt_s} -gt 1 ]]; then
            builtin exit
        else
            tmux detach-client
        fi
    else
        builtin exit
    fi
}

function force_exit() {
    builtin exit
}

function __chpwd_switch_session_group() {
    if [[ -z ${TMUX} ]]; then
        return 0
    fi
    local -a new_prj
    new_prj=$(__extract_project_from_pwd)
    if [[ "${new_prj}" != "${TMUX_SESSION_GROUP}" ]]; then
        local -a cnt_s cnt_d cid s_name
        cnt_s=$(tmux list-sessions -F '#{session_name}' | grep -e "^${new_prj}-" | wc -l)
        if [[ ${cnt_s} -eq 0 ]]; then
            # create the firest session of ${new_prj}
            tmux new-session -d -s ${new_prj}-0
            cd - &>/dev/null
            tmux switch-client -t ${new_prj}-0
        else
            # count detached sessions of ${new_prj}
            cnt_d=$(tmux list-sessions -F '#{?session_attached,,#{session_name}}' | grep -e "^${new_prj}-" | wc -l)
            if [[ ${cnt_d} -eq 0 ]]; then
                # all session is attached. so create new session
                cid=0
                s_name="${new_prj}-${cid}"
                # search session name which is not attached
                while [[ $(tmux has-session -t ${s_name} &>/dev/null; echo $?) -eq 0 ]]; do
                    cid=$((cid + 1))
                    s_name="${new_prj}-${cid}"
                done
                tmux new-session -d -s ${s_name}
                cd - &>/dev/null
                tmux switch-client -t ${s_name}
            else
                s_name=$(tmux list-sessions -F '#{?session_attached,,#{session_name}}' | grep -e "^${new_prj}-" | head -n 1)
                cd - &>/dev/null
                tmux switch-client -t ${s_name}
            fi
        fi
    fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd __chpwd_switch_session_group

function __tmux_attach_session_group(){
    local -a cnt_s cnt_d cid s_name
    cnt_s=$(tmux list-sessions -F '#{session_name}' | grep -e "^${TMUX_SESSION_GROUP}-" | wc -l)
    if [[ ${cnt_s} -eq 0 ]]; then
        # create the first session of ${TMUX_SESSION_GROUP}
        exec tmux -2u new-session -s ${TMUX_SESSION_GROUP}-0
    else
        # count detached sessions of ${TMUX_SESSION_GROUP}
        cnt_d=$(tmux list-sessions -F '#{?session_attached,,#{session_name}}' | grep -e "^${TMUX_SESSION_GROUP}-" | wc -l)
        if [[ ${cnt_d} -eq 0 ]]; then
            # all session is attached. so create new session
            cid=0
            s_name="${TMUX_SESSION_GROUP}-${cid}"
            # search session name which is not attached
            while [[ $(tmux has-session -t ${s_name} &>/dev/null; echo $?) -eq 0 ]]; do
                cid=$((cid + 1))
                s_name="${TMUX_SESSION_GROUP}-${cid}"
            done
            exec tmux -2u new-session -s ${s_name}
        else
            s_name=$(tmux list-sessions -F '#{?session_attached,,#{session_name}}' | grep -e "^${TMUX_SESSION_GROUP}-" | head -n 1)
            exec tmux -2u attach-session -t ${s_name}
        fi
    fi
}
