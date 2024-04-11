#!/bin/bash
# download hyper app from official web site and install
# https://hyper.is/
os=$(uname -s)
if [[ -e ${HOME}/.hyper.js ]]; then
    rm -f ${HOME}/.hyper.js
fi
if [[ "${os}" == "Linux" ]]; then
    ln -s ${PWD}/hyper.ubuntu.js ${HOME}/.hyper.js
else
    ln -s ${PWD}/hyper.darwin.js ${HOME}/.hyper.js
fi
