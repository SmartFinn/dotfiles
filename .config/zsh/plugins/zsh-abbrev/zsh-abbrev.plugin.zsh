typeset -gA ZSH_ABBREVIATIONS
ZSH_ABBREVIATIONS+=(
	":e"	"${EDITOR}"
	":r"	"view"
	":h"	"man"
	":q"	"exit"
	"|m"	"| more"
	"|l"	"| ${PAGER:-less}"
	"|h"	"| head"
	"|t"	"| tail"
	"|g"	"| grep"
	"|w"	"| wc"
	"|s"	"| sort"
)

magic-abbrev-expand() {
	local MATCH
	LBUFFER=${LBUFFER%%(#m)[|:_a-zA-Z0-9]#}
	LBUFFER+=${ZSH_ABBREVIATIONS[$MATCH]:-$MATCH}
	zle self-insert
}

no-magic-abbrev-expand() {
	LBUFFER+=' '
}

magic-abbrev-expand-and-accept() {
	local trailing_space
	trailing_space=${LBUFFER##*[^[:IFSSPACE:]]}

	if [[ -z $trailing_space ]]; then
		LBUFFER=${LBUFFER%%(#m)[|:_a-zA-Z0-9]#}
		LBUFFER+=${ZSH_ABBREVIATIONS[$MATCH]:-$MATCH}
	fi

	zle accept-line
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
zle -N magic-abbrev-expand-and-accept

bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand
bindkey "^M" magic-abbrev-expand-and-accept
bindkey -M isearch " " self-insert
