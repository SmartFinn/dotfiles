# file: yazi.plugin.zsh

if (( ! $+commands[yazi] )); then
	return 0
fi

# yazi - Smart alias
function yazi {
	[ -z "$YAZI_LEVEL" ] || exit 0
	command yazi "$@"
}

# Bind Alt+j / Esc j to open yazi
bindkey -s '\ej' '^qyazi\n'
