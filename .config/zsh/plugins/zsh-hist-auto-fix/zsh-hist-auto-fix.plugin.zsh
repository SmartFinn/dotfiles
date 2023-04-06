# The plugin automatically run `hist f` if exit code of the last
# command is not equal zero.
#
# requires https://github.com/marlonrichert/zsh-hist

_auto_hist_fix() {
	local last_exit_code="${(%)?}"

	# exit if hist function not exists
	typeset -f hist >/dev/null || return 0

	case "$last_exit_code" in
	0)
		return 0
		;;
	130)
		# ignore SIGINT (Ctrl-C)
		return 0
		;;
	esac

	print -P "%F{blue}auto-hist-fix%f\n" \
		"%{\e[2m%}Oops! The last command finished with a non-zero exit status:" \
		"%{\e[22m%}%F{red}%B$last_exit_code%b%f\n" \
		"%{\e[2m%}Press %{\e[22m%}%F{7}%BCtrl-Q%b%{\e[2m%} to save the command" \
		"in history without execution or %{\e[22m%}%BCtrl-C%b%{\e[2m%}" \
		"to clear.%{\e[22m%}"

	# Fix last entry (cut from history; paste into command line)
	hist -q fix -1
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _auto_hist_fix
