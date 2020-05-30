# complete words from tmux pane(s)
# Source: http://blog.plenz.com/2012-01/zsh-complete-words-from-tmux-pane.html

_tmux_pane_words() {
	local expl
	local -a w

	if [[ -z "$TMUX_PANE" ]]; then
		_message "not running inside tmux!"
		return 1
	fi

	# capture current pane first
	w=( ${(u)=$(tmux capture-pane -J -p)} )
	for i in $(tmux list-panes -F '#P'); do
		# skip current pane (handled above)
		[[ "$TMUX_PANE" = "$i" ]] && continue
		w+=( ${(u)=$(tmux capture-pane -J -p -t $i)} )
	done
	_wanted values expl 'words from current tmux pane' compadd -a w
}

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^Xt' tmux-pane-words-prefix
bindkey '^X^X' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'
