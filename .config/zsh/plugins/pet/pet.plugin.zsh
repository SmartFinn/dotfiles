# file: pet.plugin.zsh

if (( ! $+commands[pet] )); then
	return 0
fi

alias p="pet"
fpath=( $0:A:h $fpath )

function prev() {
	PREV=$(fc -lrn | head -n 1)
	sh -c "pet new -t $(printf %q "$PREV")"
}

function pet-select() {
	BUFFER=$(pet search --query "$LBUFFER")
	CURSOR=$#BUFFER
	zle redisplay
}

zle -N pet-select
stty -ixon
bindkey '\C-s' pet-select
