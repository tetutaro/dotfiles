export VIRTUAL_ENV_DISABLE_PROMPT=1
autoload -Uz colors
colors
${HOME}/.local/bin/powerline-daemon -q
POWERLINE_COMMAND="${HOME}/.local/bin/powerline"
POWERLINE_CONFIG_COMMAND="${HOME}/.local/bin/powerline-config"
. ${HOME}/.local/share/powerline-bindings/zsh/powerline.zsh
# fall back to a plain prompt if powerline renders nothing (e.g. broken segments)
if [[ -z "$("${POWERLINE_COMMAND}" shell aboveleft -r .zsh --width=80 2>/dev/null)" ]]; then
    PS1='%n@%m %~'
fi
PROMPT="${PS1}
 %B%(?,%F{green},%F{red})%(!,#,>)%f%b "
