#!/usr/bin/env bash

# pipx runpip runs in the venv directory, so "." must be an absolute path
pipx runpip powerline-status install -e "$(cd "$(dirname "$0")" && pwd)"
