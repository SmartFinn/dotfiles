if (( ! $+commands[pw-play] )); then
	return 0
fi

: ${ZSH_DING_FILE:="$0:A:h/ding.ogg"}

ding() {
	pw-play "$ZSH_DING_FILE"
}
