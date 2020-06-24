#!/usr/bin/env bash
# A Rofi plugin that allows a jump to your own, starred, and
# subscribed GitHub repositories.
# Inspired by https://github.com/AlbertExtensions/Github-Jump

# Requires:
#  - gh v0.10.1+ (https://github.com/cli/cli)
#  - jq (https://github.com/stedolan/jq)

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
	coproc xdg-open "https://github.com/$1" 2>&1
	exec 1>&-
	exit 0
}

get_gh_repos() {
	(
		command gh api --paginate user/repos &
		command gh api --paginate user/starred &
		command gh api --paginate user/subscriptions
	) | jq -r '.[] | .full_name' | awk '!seen[$0]++'
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
	case "$1" in
		!update*)
			UPDATE_CACHE=1
			;;
		*) open_in_browser "$1"
	esac
fi

add_detail_entry "!update" "update list of GitHub repositories (takes a long time)"

if [ "$UPDATE_CACHE" -eq 1 ]; then
	rm -f "$GH_JUMP_CACHE"
	get_gh_repos | tee "$GH_JUMP_CACHE"
	set_mesg "the list of the GitHub repositories is updated."
	exit 0
fi

if [ -e "$GH_JUMP_CACHE" ]; then
	cat "$GH_JUMP_CACHE"
fi
