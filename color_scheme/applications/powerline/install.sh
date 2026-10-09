#!/bin/bash
. "$(cd "$(dirname "$0")/../../.." && pwd)/lib/link.sh"

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ ! -d ${HOME}/.config/color_scheme ]; then
    mkdir ${HOME}/.config/color_scheme
fi
safe_link ${SCRIPT_DIR}/colors ${HOME}/.config/color_scheme/powerline
