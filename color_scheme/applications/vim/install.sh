#!/bin/bash
. "$(cd "$(dirname "$0")/../../.." && pwd)/lib/link.sh"

SCRIPT_DIR=$(cd $(dirname $0); pwd)
safe_link ${SCRIPT_DIR}/colors ${HOME}/.vim/colors
