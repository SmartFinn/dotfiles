command -v go >/dev/null || return 0

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

if path_missing "$PATH" "$GOPATH/bin"; then
	export PATH="$GOPATH/bin:$PATH"
fi
