#!/bin/sh
# Print one symbol for the herdr AI agents in this session, picking the state
# that needs the most attention: blocked > working > done > idle > unknown.
set -u

status=$(herdr agent list 2>/dev/null | jq -r '
    [.result.agents[].agent_status] as $s
    | first(("blocked", "working", "done", "idle", "unknown") as $k
            | select($s | index($k)) | $k) // "none"
' 2>/dev/null)

case "$status" in
    blocked) printf '%s' '#[fg=colour9,bg=colour17,bold] ▲ ' ;;
    working) printf '%s' '#[fg=colour12,bg=colour17,bold] ▶ ' ;;
    done)    printf '%s' '#[fg=colour10,bg=colour17,bold] ■ ' ;;
    idle)    printf '%s' '#[fg=colour19,bg=colour17,bold] ● ' ;;
    unknown) printf '%s' '#[fg=colour11,bg=colour17,bold] ◆ ' ;;
    *)       printf '%s' '#[fg=colour19,bg=colour17,bold] ▬ ' ;;
esac
