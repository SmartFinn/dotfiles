# file: eza.plugin.zsh

if (( ! $+commands[eza] )); then
	return 0
fi

alias eza="command eza --group-directories-first --classify"
alias l="eza"
alias ll="eza -l"
