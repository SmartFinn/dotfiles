# Copy current command to clipboard (Ctrl+X c)
# https://www.reddit.com/r/commandline/comments/4fjpb0/question_how_to_copy_the_command_to_clipboard/

buffer_to_clipboard() {
	printf '%s' "$BUFFER" | clipcopy
}

zle -N buffer_to_clipboard
bindkey '^Xc' buffer_to_clipboard
