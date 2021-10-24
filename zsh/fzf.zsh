## fzf
export FZF_COMPLETION_TRIGGER="@"
export FZF_DEFAULT_COMMAND='ag --ignore "Library" --ignore "Applications" --ignore "Pictures" --ignore "Music" --ignore "Movies" --ignore "__pycache__" --nocolor -g ""'
export FZF_DEFAULT_OPTS="--tac --cycle --layout=reverse --no-multi --no-exit-0 --no-select-1"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'head -n 40 {}' --preview-window right:50%:hidden:nowrap --bind '?:toggle-preview'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_COMMAND="find -L . -mindepth 1 -maxdepth 3 \( -path '*/.*' -or -path '*/_*' -or -fstype 'sysfs' -or -fstype 'devfs' -or -fstype 'devtmpfs' -or -fstype 'proc' -or -path '*/Library*' -or -path '*/Applications*' -or -path '*/Pictures*' -or -path '*/Music*' -or -path '*/Movies*' -or -path '*/Google Drive*' -or -path '*/Dropbox*' -or -path '*/VirtualBox VMs*' \) -prune -or -type d -print 2>/dev/null | cut -b3-"
export FZF_ALT_C_OPTS="--preview 'tree -L 1 -C {} | head -n 40' --preview-window right:50%:hidden:nowrap --bind '?:toggle-preview'"

source ${HOME}/.config/fzf/fzf.zsh

bindkey -r "^T"
bindkey -r "\ec"
bindkey "^X^F" fzf-file-widget
bindkey "^X^D" fzf-cd-widget
