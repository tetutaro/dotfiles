#!/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"
# download hyper app from official web site and install
# https://hyper.is/
os=$(uname -s)
if [[ "${os}" == "Linux" ]]; then
    safe_link ${PWD}/hyper.ubuntu.js ${HOME}/.hyper.js
else
    safe_link ${PWD}/hyper.darwin.js ${HOME}/.hyper.js
fi
