if (( ! $+commands[paplay] )); then
	return 0
fi

: ${ZSH_DING_FILE:="$0:A:h/ding.ogg"}

ding() {
	paplay "$ZSH_DING_FILE"
}
