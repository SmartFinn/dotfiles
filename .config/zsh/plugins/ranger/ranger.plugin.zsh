# file: ranger.plugin.zsh

if (( ! $+commands[ranger] )); then
	return 0
fi

# Change the prompt when you open a shell from inside ranger
# [ -z "$RANGER_LEVEL" ] || RPROMPT+=" %F{magenta}(ranger)%f"

# Automatically change the directory in bash after closing ranger
#
# This function automatically change the directory to the last visited one
# after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.

function _ranger-cd {
	tempfile="$(mktemp -u --tmpdir ranger_lastdir.XXXXXX)"
	ranger --choosedir="$tempfile" "${@:-$PWD}"

	if [ -f "$tempfile" ]; then
		builtin cd -- "$(<"$tempfile")"
		command rm -f -- "$tempfile"
	fi
}

# Bind Ctrl-] to ranger-cd:
bindkey -s '\C-]' '^q_ranger-cd\n'

# ranger - Smart alias
function ranger {
	[ -z "$RANGER_LEVEL" ] || exit
	command ranger "$@"
}

# Bind Alt+j / Esc j to open ranger
bindkey -s '\ej' '^qranger\n'
