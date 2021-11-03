function __list_projects() {
    local -a projects
    projects=($(find -L ${PROJECT_TOP_DIR} -type d -mindepth ${PROJECT_DEPTH_FROM_TOP} -maxdepth ${PROJECT_DEPTH_FROM_TOP} \( -name '.*' -or -name '_*' \) -prune -or -type d -print 2>/dev/null | rev | cut -d/ -f-${PROJECT_DEPTH_FROM_TOP} | rev | sort))
    print -r -- ${(qq)projects}
}

function cdp() {
    local -a dir prj
    if [[ -z "$1" ]]; then
        dir=${PWD##${PROJECT_TOP_DIR}/}
        if [[ "${dir}" == "${PWD}" ]]; then
            pushd "${PROJECT_TOP_DIR}" >/dev/null
        else
            if [[ ${(w)#${(ps:/:)dir}} -lt ${PROJECT_DEPTH_FROM_TOP} ]]; then
                pushd "${PROJECT_TOP_DIR}" >/dev/null
            else
                prj=${(j:/:)${${(ps:/:)dir}[(w)1,(w)${PROJECT_DEPTH_FROM_TOP}]}}
                pushd "${PROJECT_TOP_DIR}/${prj}" >/dev/null
            fi
        fi
    else
        dir=$(echo ${(F)${(@Q)${(z)$(__list_projects)}}} | ${FZF_COMMAND} --prompt "Project > " --preview "tree -L 1 -N ${PROJECT_TOP_DIR}/{} | head -n 40" --preview-window right:50%:nowrap:hidden --bind "?:toggle-preview" --query "$1")
        if [[ "${dir}" != "" ]]; then
            pushd "${PROJECT_TOP_DIR}/${dir}" >/dev/null
        fi
    fi
}
function __cdp_widget() {
    local -a buffer cmd arg dir
    buffer="${LBUFFER}${RBUFFER}"
    cmd=${${(ws, ,)buffer}[1]}
    arg=${${(ws, ,)buffer}[2]}
    if [[ ${cmd} == "cdp" ]]; then
        dir=$(echo ${(F)${(@Q)${(z)$(__list_projects)}}} | ${FZF_COMMAND} --prompt "Project > " --preview "tree -L 1 -N ${PROJECT_TOP_DIR}/{} | head -n 40" --preview-window right:50%:nowrap:hidden --bind "?:toggle-preview" --query "${arg}")
        if [[ "${dir}" != "" ]]; then
            pushd "${PROJECT_TOP_DIR}/${dir}" >/dev/null
            zle accept-line
            LBUFFER=""
            RBUFFER=""
        else
            zle reset-prompt
            LBUFFER=""
            RBUFFER=""
        fi
    else
        zle expand-or-complete
    fi
}
zle -N __cdp_widget
bindkey "^I" __cdp_widget
