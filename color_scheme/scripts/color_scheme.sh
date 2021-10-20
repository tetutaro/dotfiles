if [[ ${TERM##*-} == "256color" ]]; then
    if [[ -f ${HOME}/.config/color_scheme/shell.sh ]]; then
        source ${HOME}/.config/color_scheme/shell.sh
    fi
    if [[ ! -z $(command -v fzf) ]] && [[ -f ${HOME}/.config/color_scheme/fzf.sh ]]; then
        source ${HOME}/.config/color_scheme/fzf.sh
    fi
fi
