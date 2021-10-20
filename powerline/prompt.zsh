export VIRTUAL_ENV_DISABLE_PROMPT=1
autoload -Uz colors
colors
${HOME}/.local/bin/powerline-daemon -q
POWERLINE_COMMAND="${HOME}/.local/bin/powerline"
POWERLINE_CONFIG_COMMAND="${HOME}/.local/bin/powerline-config"
. ${HOME}/.local/share/powerline-bindings/zsh/powerline.zsh
PROMPT="${PS1}
%n@%m %B%(?,%F{green},%F{red})%(!,#,>)%f%b "
