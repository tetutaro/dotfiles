#!/usr/bin/env bash
set -euCo pipefail
if [ $# -eq 0 ]; then
    echo "PowerOff"
    echo "Reboot"
else
    case "$1" in
        "PowerOff")
            systemctl poweroff
            ;;
        "Reboot")
            systemctl reboot
            ;;
        *)
            notify-send "Rofi: Invalid Command: $1"
            ;;
    esac
fi
