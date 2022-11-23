command -v fzf >/dev/null || return 0

FZF_DEFAULT_OPTS+=' --border=rounded'
FZF_DEFAULT_OPTS+=' --layout=reverse'
FZF_DEFAULT_OPTS+=' --height=90%'
FZF_DEFAULT_OPTS+=' --tabstop=4'
FZF_DEFAULT_OPTS+=' --preview-window=:right:60%:border-left'
FZF_DEFAULT_OPTS+=' --marker="✓"'
FZF_DEFAULT_OPTS+=' --bind "?:toggle-preview"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-space:toggle+down"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-alt-a:select-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-alt-d:deselect-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-alt-t:toggle-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-j:preview-half-page-down"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-k:preview-half-page-up"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-o:execute-multi($EDITOR -p {} > /dev/tty)"'
export FZF_DEFAULT_OPTS
export FZF_COMPLETION_TRIGGER="**"

if command -v fd >/dev/null; then
	# fzf's command
	export FZF_DEFAULT_COMMAND="fd"
	# CTRL-T's command
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
	# ALT-C's command
	export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
fi
