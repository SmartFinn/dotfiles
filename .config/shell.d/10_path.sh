# set PATH so it includes user's private bin if it exists
for dir in "$HOME/.local/bin" "$HOME/.bin" "$HOME/bin"; do
	[ -d "$dir" ] || continue
	path_missing "$PATH" "$dir" || continue
	PATH="$dir:$PATH"
done

export PATH
unset dir
