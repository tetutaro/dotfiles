#!/bin/bash
. "$(cd "$(dirname "$0")/.." && pwd)/lib/link.sh"
safe_link ${PWD}/latexmkrc ${HOME}/.latexmkrc
