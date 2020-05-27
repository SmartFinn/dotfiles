#!/usr/bin/env bash
# inspired by https://github.com/AlbertExtensions/Github-Jump

set -e

: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${YT_JUMP_CACHE="$XDG_CACHE_HOME/rofi-yt-jump.cache"}"

open_in_browser() {
	coproc xdg-open "$1" 2>&1
	exec 1>&-
	exit 0
}

set_mesg() {
	printf '\0message\x1f<span size="small">%s</span>\n' "$1"
}

add_entry() {
	printf '%s\n' "$1"
}

add_detail_entry() {
	printf '\0markup-rows\x1ftrue\n'
	printf '%s\t<span size="smaller" style="italic">%s</span>\n' "$1" "$2"
}

add_warning_msg() {
	printf '\0markup-rows\x1ftrue\n'
	printf '<span bgcolor="#EEEE0055">%s</span>\n' "$1"
}

# Handle argument.
if [ -n "$1" ]; then
	channel_url="$(awk -F'\t' -v channel_name="$1" '$1 == channel_name {print $2}' "$YT_JUMP_CACHE")"
	case "$1" in
		*) open_in_browser "$channel_url"
	esac
fi

if [ -e "$YT_JUMP_CACHE" ]; then
	awk -F'\t' '{print $1}' "$YT_JUMP_CACHE"
fi
