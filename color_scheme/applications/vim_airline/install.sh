#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ -L ${HOME}/.vim/autoload/airline/themes ]; then
    rm -f ${HOME}/.vim/autoload/airline/themes
fi
mkdir -p ${HOME}/.vim/autoload/airline
ln -sf ${SCRIPT_DIR}/themes ${HOME}/.vim/autoload/airline/themes
