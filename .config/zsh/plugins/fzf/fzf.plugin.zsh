if (( ! $+commands[fzf] )); then
	return 1
fi

[ -f /usr/share/fzf/shell/key-bindings.zsh ] &&
	source /usr/share/fzf/shell/key-bindings.zsh

[ -f /usr/share/zsh/site-functions/fzf ] &&
	source /usr/share/zsh/site-functions/fzf
