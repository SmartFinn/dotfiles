# file: aichat-integration.plugin.zsh

if (( ! $+commands[aichat] )); then
	return 0
fi

if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/aichat/shell-integration/integration.zsh" ]
then
	source "${XDG_DATA_HOME:-$HOME/.local/share}/aichat/shell-integration/integration.zsh"
fi
