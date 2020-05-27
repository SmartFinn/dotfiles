command -v rvm >/dev/null || return 0

if [ -f "$HOME/.rvm/environments/default" ]; then
	. "$HOME/.rvm/environments/default"
fi
