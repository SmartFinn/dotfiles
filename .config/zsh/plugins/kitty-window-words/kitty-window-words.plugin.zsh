# complete words from the current kitty window
# Based on: http://blog.plenz.com/2012-01/zsh-complete-words-from-tmux-pane.html

# Do not load this plugin outside the Kitty window
if [ -z "$KITTY_PID" ]; then
	return 0
fi

_kitty_window_words() {
	local expl
	local -a w

	if [[ -z "$KITTY_PID" ]]; then
		_message "not running inside kitty!"
		return 1
	fi

	# get words from the current window
	w=( ${(u)=$(kitty @ get-text --self)} )

	# remove words less than 3 symbols
	w=( ${(M)w:#???*} )

	_wanted values expl 'words from the current kitty window' compadd -a w
}

zle -C kitty-window-words complete-word _generic
bindkey '^X^X' kitty-window-words
zstyle ':completion:kitty-window-words:*' completer _kitty_window_words
zstyle ':completion:kitty-window-words:*' ignore-line current
zstyle ':completion:kitty-window-words:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'
