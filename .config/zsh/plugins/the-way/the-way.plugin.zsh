# file: the-way.plugin.zsh

if (( ! $+commands[the-way] )); then
	return 0
fi

function cmdsave() {
	PREV=$(fc -lrn | head -n 1)
	sh -c "the-way cmd $(printf %q "$PREV")"
}

function cmdsearch() {
	BUFFER=$(the-way search --stdout --languages="sh")
	CURSOR=$#BUFFER
	zle redisplay
}

zle -N cmdsearch
stty -ixon
bindkey '\C-s' cmdsearch
