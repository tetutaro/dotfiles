#!/usr/bin/bash

if [[ ! -e ${HOME}/.config/opencode/opencode.json ]]; then
    echo "Installing OpenCode configuration file..."
    mkdir -p ${HOME}/.config/opencode
    ln -s ${PWD}/opencode.json ${HOME}/.config/opencode/opencode.json
    ln -s ${PWD}/AGENTS.md ${HOME}/.config/opencode/AGENTS.md
    mkdir -p ${HOME}/.config/opencode/agent
    for file in `ls -1 agent/`; do
        ln -s ${PWD}/agent/${file} ${HOME}/.config/opencode/agent/${file}
    done
    echo "OpenCode configuration file installed"
else
    echo "OpenCode configuration file already exists."
fi
