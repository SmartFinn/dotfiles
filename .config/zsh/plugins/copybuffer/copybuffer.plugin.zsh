# Copy current command to clipboard (Ctrl+X c)
# https://www.reddit.com/r/commandline/comments/4fjpb0/question_how_to_copy_the_command_to_clipboard/

copybuffer() {
	printf '%s' "$BUFFER" | clipcopy
	zle -M "📋Copied the buffer to clipboard."
}

zle -N copybuffer
bindkey '^Xc' copybuffer
