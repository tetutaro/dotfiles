## fzf
export FZF_COMPLETION_TRIGGER="@"
export FZF_DEFAULT_COMMAND='ag --ignore "Library" --ignore "Applications" --ignore "Pictures" --ignore "Music" --ignore "Movies" --ignore "__pycache__" --nocolor -g ""'
export FZF_DEFAULT_OPTS="--tac --cycle --layout=reverse --select-1 --exit-0"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'head -100 {}' --preview-window down:50%:hidden:wrap --bind '?:toggle-preview'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.*' -or -fstype 'sysfs' -or -fstype 'devfs' -or -fstype 'devtmpfs' -or -fstype 'proc' -or -path '*/Library' -or -path '*/Applications' -or -path '*/Pictures' -or -path '*/Music' -or -path '*/Movies' -or -path '*/__pycache__' \\) -prune -or -type d -print 2>/dev/null | cut -b3-"
export FZF_ALT_C_COMMAND="find -L . -mindepth 1 -maxdepth 3 \( -path '*/.*' -o -path '*Library*' -o -path '*Applications*' -o -path '*Google Drive*' -o -path '*Dropbox*' -o -path '*VirtualBox VMs*' \) -prune -o -type d -print 2>/dev/null | cut -b3-"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100' --preview-window down:50%:hidden:wrap --bind '?:toggle-preview'"
source ${HOME}/.config/fzf/fzf.zsh
bindkey -r "^T"
bindkey -r "\ec"
bindkey "^X^F" fzf-file-widget
bindkey "^X^D" fzf-cd-widget

## cdp
PROJECT_TOP_DIR="${HOME}/Projects"
PROJECT_DEPTH_FROM_TOP=3
function __list_projects() {
    local -a projects
    projects=($(find -L ${PROJECT_TOP_DIR} -type d -mindepth ${PROJECT_DEPTH_FROM_TOP} -maxdepth ${PROJECT_DEPTH_FROM_TOP} \( -name '.*' -or -name '_*' \) -prune -or -type d -print 2>/dev/null | rev | cut -d/ -f-${PROJECT_DEPTH_FROM_TOP} | rev | sort))
    print -r -- ${(qq)projects}
}
function cdp() {
    local -a dir
    if [[ -z "$1" ]]; then
        pushd "${PROJECT_TOP_DIR}" >/dev/null
    else
        dir=$(echo ${(F)${(@Q)${(z)$(__list_projects)}}} | fzf --no-multi --no-exit-0 --no-select-1 --preview "tree -N ${PROJECT_TOP_DIR}/{} | head -20" --preview-window down:50%:nowrap:hidden --bind "?:toggle-preview" --query "$1")
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
        dir=$(echo ${(F)${(@Q)${(z)$(__list_projects)}}} | fzf --no-multi --no-exit-0 --no-select-1 --preview "tree -N ${PROJECT_TOP_DIR}/{} | head -20" --preview-window down:50%:nowrap:hidden --bind "?:toggle-preview" --query "${arg}")
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
