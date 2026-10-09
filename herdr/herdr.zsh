export TERM="xterm-256color"
export FZF_TMUX=0
export FZF_COMMAND="fzf"

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

# project of this shell (panes do not inherit the launching shell's env)
typeset -g HERDR_PROJECT=$(__extract_project_from_pwd)

## for compatible
# herdr keeps panes alive after detach, so exit needs no special handling
function force-exit() {
    builtin exit
}

# focus the workspace labeled ${1}; create it (in ${PWD}) if it does not exist
function __herdr_focus_workspace() {
    local prj=${1} wid
    wid=$(herdr workspace list 2>/dev/null \
        | jq -r --arg l "${prj}" '.result.workspaces[] | select(.label == $l) | .workspace_id' \
        | head -n 1)
    if [[ -z ${wid} ]]; then
        herdr workspace create --cwd "${PWD}" --label "${prj}" --focus &>/dev/null
    else
        herdr workspace focus "${wid}" &>/dev/null
    fi
}

function __chpwd_switch_workspace() {
    if [[ ${HERDR_ENV} != 1 ]]; then
        return 0
    fi
    local new_prj
    new_prj=$(__extract_project_from_pwd)
    if [[ "${new_prj}" != "${HERDR_PROJECT}" ]]; then
        # the new workspace starts in ${PWD}, so return this pane to where it was
        __herdr_focus_workspace ${new_prj}
        cd - &>/dev/null
    fi
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd __chpwd_switch_workspace

# keep the function name used by zshrc
function __tmux_attach_session_group() {
    if [[ ${HERDR_ENV} == 1 ]]; then
        return 0
    fi
    exec herdr
}
