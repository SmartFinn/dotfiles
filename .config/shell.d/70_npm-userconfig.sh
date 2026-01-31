command -v npm >/dev/null || return 0

# Set a path to npm config
if [ -z "$NPM_CONFIG_USERCONFIG" ]; then
	export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
fi

# Indicate to npm where to store globally installed packages
if [ ! -s "$NPM_CONFIG_USERCONFIG" ]; then
	mkdir -p "$(dirname "$NPM_CONFIG_USERCONFIG")"
	cat > "$NPM_CONFIG_USERCONFIG" <<- 'EOF'
	prefix=${HOME}/.local/share/npm
	cache=${HOME}/.cache/npm
	init-module=${HOME}/.config/npm/config/npm-init.js
	EOF
fi

npm_prefix="$(npm config get prefix)"

[ -n "$npm_prefix" ] || return 0

# Ensure npm will find installed binaries and man pages
if path_missing "$PATH" "$npm_prefix/bin"; then
	export PATH="$npm_prefix/bin:$PATH"
fi

# Set manpath
if path_missing "$(manpath 2>/dev/null)" "$npm_prefix/share/man"; then
	MANPATH="$npm_prefix/share/man:$(manpath 2>/dev/null)"
	export MANPATH
fi

unset npm_prefix
