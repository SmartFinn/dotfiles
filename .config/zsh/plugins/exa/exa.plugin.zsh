# file: exa.plugin.zsh

if (( ! $+commands[exa] )); then
	return 0
fi

alias exa="command exa --group-directories-first --classify"
alias l="exa"
alias ll="exa -l"
