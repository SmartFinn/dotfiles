# System clipboard integration
#
# This file has support for doing system clipboard copy and paste operations
# from the command line in a generic cross-platform fashion.
#
# On OS X and Windows, the main system clipboard or "pasteboard" is used. On other
# Unix-like OSes, this considers the X Windows CLIPBOARD selection to be the
# "system clipboard", and the X Windows `xclip` command must be installed.

# clipcopy - Copy data to clipboard
#
# Usage:
#
#  <command> | clipcopy    - copies stdin to clipboard
#
#  clipcopy <file>         - copies a file's contents to clipboard
#
function clipcopy() {
	emulate -L zsh
	local file="$1"

	case "$OSTYPE" in
		darwin*)
			if [[ -z $file ]]; then
				pbcopy
			else
				cat "$file" | pbcopy
			fi
			;;
		cygwin*)
			if [[ -z $file ]]; then
				cat > /dev/clipboard
			else
				cat "$file" > /dev/clipboard
			fi
			;;
		linux*)
			if [ -n "${WAYLAND_DISPLAY:-}" ]; then
				if (( ${+commands[wl-copy]} )); then
					if [[ -z $file ]]; then
						wl-copy
					else
						cat "$file" | wl-copy
					fi
				else
					print "clipcopy: wl-copy not installed" >&2
					return 1
				fi
			else
				if (( $+commands[xsel] )); then
					if [[ -z $file ]]; then
						xsel --clipboard --input
					else
						cat "$file" | xsel --clipboard --input
					fi
				elif (( $+commands[xclip] )); then
					if [[ -z $file ]]; then
						xclip -in -selection clipboard
					else
						xclip -in -selection clipboard "$file"
					fi
				else
					print "clipcopy: xclip/xsel not installed" >&2
					return 1
				fi
			fi
			;;
		*)
			print "clipcopy: Platform $OSTYPE not supported" >&2
			return 1
	esac
}

# clippaste - "Paste" data from clipboard to stdout
#
# Usage:
#
#   clippaste   - writes clipboard's contents to stdout
#
#   clippaste | <command>    - pastes contents and pipes it to another process
#
#   clippaste > <file>      - paste contents to a file
#
# Examples:
#
#   # Pipe to another process
#   clippaste | grep foo
#
#   # Paste to a file
#   clippaste > file.txt
function clippaste() {
	emulate -L zsh

	case "$OSTYPE" in
		darwin*)
			pbpaste
			;;
		cygwin*)
			cat /dev/clipboard
			;;
		linux*)
			if [ -n "${WAYLAND_DISPLAY:-}" ]; then
				if (( ${+commands[wl-paste]} )); then
					wl-paste
				else
					print "clipcopy: wl-paste not installed" >&2
					return 1
				fi
			else
				if (( $+commands[xsel] )); then
					xsel --clipboard --output
				elif (( $+commands[xclip] )); then
					xclip -out -selection clipboard
				else
					print "clipcopy: xclip/xsel not installed" >&2
					return 1
				fi
			fi
			;;
		*)
			print "clipcopy: Platform $OSTYPE not supported" >&2
			return 1
	esac
}

# clip - Smart alias
#
# Usage:
#
#   clip | <command>   - pastes contents and pipes it to another process
#   clip > <file>      - paste contents to a file
#   <command> | clip   - copies stdin to clipboard
function clip() {
	if [[ -t 0 ]]; then
		clippaste
	else
		clipcopy
	fi
}
