#!/bin/sh
# Print the focused herdr workspace and its tabs as tmux-powerline styled
# status-line segments (port of tmux/tmux-powerline/themes/default.sh:
# tmux_session_info segment + window list).
set -u

SEP_RIGHT_BOLD=$(printf '\356\202\260')
SEP_RIGHT_THIN=$(printf '\356\202\261')

# focused workspace: "<workspace_id>\t<label>"
ws=$(herdr workspace list 2>/dev/null | jq -r '
    .result.workspaces[] | select(.focused) | "\(.workspace_id)\t\(.label)"
' 2>/dev/null | head -n 1)
[ -n "$ws" ] || exit 0
ws_id=$(printf '%s' "$ws" | cut -f1)
# `#` starts a tmux format, so double it
ws_label=$(printf '%s' "$ws" | cut -f2- | sed 's/#/##/g')

out="#[fg=colour12,bg=colour17] $ws_label #[fg=colour17,bg=colour17]$SEP_RIGHT_BOLD"

# tabs: "<focused>\t<number>\t<label>" per line
tabs=$(herdr tab list --workspace "$ws_id" 2>/dev/null | jq -r '
    .result.tabs[] | "\(.focused)\t\(.number)\t\(.label | gsub("#"; "##"))"
' 2>/dev/null)

tab_out=$(printf '%s\n' "$tabs" | while IFS="$(printf '\t')" read -r focused number label; do
    [ -n "$number" ] || continue
    if [ "$focused" = true ]; then
        printf '%s' "#[fg=colour17,bg=colour16]$SEP_RIGHT_BOLD#[fg=colour10,bg=colour16] $label #[fg=colour16,bg=colour17]$SEP_RIGHT_BOLD"
    else
        printf '%s' "#[fg=colour7,bg=colour17]  $number  $SEP_RIGHT_THIN $label "
    fi
done)

printf '%s%s#[default]\n' "$out" "$tab_out"
