[ -x "$HOME/.linuxbrew/bin/brew" ] || return 0

# eval $("$HOME/.linuxbrew/bin/brew" shellenv)

export HOMEBREW_PREFIX="$HOME/.linuxbrew"
export HOMEBREW_CELLAR="$HOME/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="$HOME/.linuxbrew/Homebrew"

if path_missing "$PATH" "$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin"; then
	export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
fi

if path_missing "$(manpath 2>/dev/null)" "$HOME/.linuxbrew/share/man"; then
	MANPATH="$HOME/.linuxbrew/share/man:$(manpath 2>/dev/null)"
	export MANPATH
fi

if path_missing "$INFOPATH" "$HOME/.linuxbrew/share/info"; then
	export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi

if path_missing "$FPATH" "$HOMEBREW_PREFIX/share/zsh/site-functions"; then
	export FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"
fi
