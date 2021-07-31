# file: mcfly.plugin.zsh

if (( ! $+commands[mcfly] )); then
	return 0
fi

export MCFLY_RESULTS=$(tput lines)

eval "$(mcfly init zsh)"
