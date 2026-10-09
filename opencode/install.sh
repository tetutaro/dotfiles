#!/usr/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"

echo "Installing OpenCode configuration file..."
safe_link ${PWD}/opencode.json ${HOME}/.config/opencode/opencode.json
safe_link ${PWD}/AGENTS.md ${HOME}/.config/opencode/AGENTS.md
for file in `ls -1 agent/`; do
    safe_link ${PWD}/agent/${file} ${HOME}/.config/opencode/agent/${file}
done
echo "OpenCode configuration file installed"
