if (( ! $+commands[gio] )); then
	return 1
fi

alias trash="gio trash"
alias trash-empty="gio trash --empty"
alias trash-ls="gio list trash://"
alias trash-size="du -sh ~/.local/share/Trash/"
