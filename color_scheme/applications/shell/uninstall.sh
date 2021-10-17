#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ -e ${HOME}/.config/frontemare-shell ]; then
    rm -f ${HOME}/.config/frontemare-shell
fi
