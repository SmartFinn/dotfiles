#!/usr/bin/env bash
# A Rofi plugin that allows a jump to your own, starred, and
# subscribed GitHub repositories.
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
: "${GH_JUMP_CACHE="$XDG_CACHE_HOME/rofi-gh-jump.cache"}"

open_in_browser() {
	coproc xdg-open "$1" 2>&1
	exec 1>&-
	exit 0
}

get_gh_repos() {
	local jq_query=".[] | [.full_name, .html_url, .description] | @tsv"
	(
		command gh api --paginate --jq "$jq_query" user/repos &
		command gh api --paginate --jq "$jq_query" user/starred &
		command gh api --paginate --jq "$jq_query" user/subscriptions &
	) | awk -F$'\t' '!seen[$1]++'
}

set_mesg() {
	printf '\0message\x1f<span fgcolor="#3ddd3d" size="small">%s</span>\n' "$1"
}

add_entry() {
	printf '%s <span weight="light" size="small"><i>(%s)</i></span>\0info\x1f%s\n' "$1" "$2" "$3"
}

# Handle action
if [ -n "$ROFI_INFO" ]; then
	case "$ROFI_INFO" in
		update)
			UPDATE_CACHE=1
			;;
		http*)
			open_in_browser "$ROFI_INFO"
			;;
	esac
fi

# Hadle argument
if [ -z "$ROFI_INFO" ] && [ -n "$1" ]; then
	open_in_browser "https://github.com/search?q=${1}&ref=opensearch"
fi

if [ "$UPDATE_CACHE" -eq 1 ] || [ ! -s "$GH_JUMP_CACHE" ]; then
	rm -f "$GH_JUMP_CACHE"
	get_gh_repos | tee "$GH_JUMP_CACHE" > /dev/null
	set_mesg "the list of the GitHub repositories is updated."
fi

# Enable Pango markup
printf '\0markup-rows\x1ftrue\n'

add_entry "!update" "update list of GitHub repositories (takes a long time)" "update"

if [ -e "$GH_JUMP_CACHE" ]; then
	while IFS=$'\t' read -r full_name html_url desc; do
		add_entry "$full_name" "$desc" "$html_url"
	done < "$GH_JUMP_CACHE"
fi
