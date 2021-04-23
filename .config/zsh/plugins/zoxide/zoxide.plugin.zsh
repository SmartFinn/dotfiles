# file: zoxide.plugin.zsh

if (( ! $+commands[zoxide] )); then
	return 0
fi

compdef z=cd

eval "$(zoxide init zsh)"
