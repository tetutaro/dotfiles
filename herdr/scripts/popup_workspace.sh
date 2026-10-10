#!/usr/bin/env bash

# 1. ワークスペースの一覧を取得してfzfで選択
selected_workspace_info=$(herdr workspace list | jq -c '.result.workspaces[] | [ ("000" + (.number | tostring) | .[-3:]), ": \(.label) (ID:\(.workspace_id))",  if .focused == true then " (current)" else "" end ]' | jq 'join("")' | sed 's/^"//; s/"$//' | sort -nr | fzf --header "Select Workspace")
if [[ "x${selected_workspace_info}" == "x" ]]; then
    # invalid information
    exit 0
fi
if [[ "x${selected_workspace_info}" == *"(current)" ]]; then
    # Select Current Workspace
    exit 0
fi
# 2. 選択されたワークスペースがあれば切り替える
selected_workspace_id=$(echo "${selected_workspace_info}" | sed -E 's/.*\(ID:([^)]+)\).*/\1/')
if [[ "x${selected_workspace_id}" == "x" ]] then
    exit 0
fi
herdr workspace focus "${selected_workspace_id}"
