# The plugin automatically activate virtualenvs

activate_venv() {
	[[ -z "$VIRTUAL_ENV" ]] || return 0

	typeset top_dirs=(
		'.'
		'..'
		'../..'
		"$(git rev-parse --show-toplevel 2>/dev/null)"
	)

	typeset venv_dirs=(
		'venv'
		'.venv'
		'virtualenv'
		'.virtualenv'
	)

	for top_dir in "${top_dirs[@]}"; do
		for venv_dir in "${venv_dirs[@]}"; do
			[[ -f "$top_dir/$venv_dir/bin/activate" ]] || continue

			source "$top_dir/$venv_dir/bin/activate"
			break
		done
	done
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd activate_venv

activate_venv
