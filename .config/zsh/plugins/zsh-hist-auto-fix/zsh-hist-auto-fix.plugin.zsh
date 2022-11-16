# The plugin automatically run `hist f` if exit code of the last
# command is not equal zero.
#
# requires https://github.com/marlonrichert/zsh-hist

# exit immediately if hist function not exists
typeset -f hist >/dev/null || return 0

_auto_hist_fix() {
	local last_exit_code="${(%)?}"

	[ "$last_exit_code" -eq 0 ] && return 0

	# ignore SIGINT (Ctrl-C)
	[ "$last_exit_code" -eq 130 ] && return 0

	print -P "%F{blue}auto-hist-fix%f\n" \
		"Press %F{green}Ctrl-Q%f to save the command in history" \
		"without execution or %F{red}Ctrl-C%f to clear"

	# Fix last entry (cut from history; paste into command line)
	hist -q fix -1
}

bindkey '^Q' push-line-or-edit

autoload -Uz add-zsh-hook
add-zsh-hook precmd _auto_hist_fix
