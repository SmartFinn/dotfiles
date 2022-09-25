#!/usr/bin/env bash
# A Rofi plugin that allows to jump to your own and starred Gists
# Inspired by https://github.com/AlbertExtensions/Github-Jump

# Requires:
#  - gh v1.7.0+ (https://github.com/cli/cli)

# Copyright (c) 2020 Sergei Eremenko (https://github.com/SmartFinn)
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.


set -e

: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${UPDATE_CACHE:=0}"
: "${GIST_JUMP_CACHE="$XDG_CACHE_HOME/rofi-gist-jump.cache"}"

open_in_browser() {
	[ -n "$ROFI_INFO" ] || return 1

	coproc xdg-open "$ROFI_INFO" 2>&1
	exec 1>&-
	exit 0
}

get_gists() {
	local jq_query=".[] | [{html_url, file: .files[].filename, description}] | \
		.[] | [.html_url, .file, .description] | @tsv"
	(
		command gh api --paginate --jq "$jq_query" gists &
		command gh api --paginate --jq "$jq_query" gists/starred &
	) | awk -F$'\t' '!seen[$1]++'
}

set_mesg() {
	printf '\0message\x1f<span weight="light" size="small">%s</span>\n' "$1"
}

add_entry() {
	printf '%s <span weight="light" size="small"><i>(%s)</i></span>\0info\x1f%s\n' "$1" "$2" "$3"
}

add_custom_entry() {
	printf '\0markup-rows\x1ftrue\n'
	printf '%s <span weight="light" size="small"><i>%s</i></span>\n' "$1" "$2"
}

add_warning_msg() {
	printf '\0markup-rows\x1ftrue\n'
	printf '<span bgcolor="#EEEE0055">%s</span>\n' "$1"
}

# Handle argument.
if [ -n "$1" ]; then
	case "$1" in
		!update*)
			UPDATE_CACHE=1
			;;
		*) open_in_browser "$1"
	esac
fi

add_custom_entry "!update" "update list of GitHub Gist (takes a long time)"

if [ "$UPDATE_CACHE" -eq 1 ] || [ ! -s "$GIST_JUMP_CACHE" ]; then
	rm -f "$GIST_JUMP_CACHE"
	get_gists | tee "$GIST_JUMP_CACHE" > /dev/null
	set_mesg "the list of the GitHub Gists is updated."
fi

if [ -e "$GIST_JUMP_CACHE" ]; then
	while IFS=$'\t' read -r html_url file desc; do
		add_entry "$file" "$desc" "$html_url"
	done < "$GIST_JUMP_CACHE"
fi
