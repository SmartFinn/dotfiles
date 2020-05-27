#!/usr/bin/env bash
# inspired by https://github.com/AlbertExtensions/Github-Jump

set -e

: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${UPDATE_CACHE:=0}"
: "${GH_JUMP_CACHE="$XDG_CACHE_HOME/rofi-gh-jump.cache"}"

_request() {
	local path="${1:?Path is required.}"; shift 1
	local api_url="https://api.github.com"

	case "$path" in
		http*) true ;;
		/*) path="${api_url}${path}" ;;
		*) path="${api_url}/${path}"
	esac

	curl -nsSig \
		-H "Accept: application/vnd.github.v3+json" \
		-H "Content-Type: application/json" \
		"${path}"
}

_response() {
	local -A headers=()
	local http_version
	local status_code
	local status_text
	local crlf

	crlf=$(printf '\r\n')

	read -r http_version status_code status_text

	headers=(
		[http_version]="${http_version#HTTP/}"
		[status_code]="${status_code}"
		[status_text]="${status_text%${crlf}}"
	)

	while IFS=": " read -r hdr val; do
		# Headers stop at the first blank line.
		[ "$hdr" = "$crlf" ] && break

		val="${val%${crlf}}"

		# Process each header
		case "$hdr" in
			Link)
				# Split the URLs in the separate pseudo-headers
				eval "$(printf '%s' "$val" | awk '
					BEGIN { RS=", "; FS="; "; OFS="=" }
					{
						sub(/^rel="/, "", $2); sub(/"$/, "", $2)
						sub(/^ *</, "", $1); sub(/>$/, "", $1)
						print "headers[Link_" $2 "]", $1
					}')"
				continue
				;;
		esac

		headers["$hdr"]="$val"

	done

	# Output requested headers in deterministic orde
	for arg in "$@"; do
		printf '%s\n' "${headers["$arg"]}"
	done

	cat
}

_get() {
	local path="${1:?Path is required.}"; shift 1
	local status_code
	local status_text
	local next_url

	_request "$path" | _response status_code status_text Link_next | {
		read -r status_code
		read -r status_text
		read -r next_url

		case "$status_code" in
			4*) printf 'Client Error: %s %s\n' \
				"$status_code" "$status_text" 1>&2; exit 1 ;;
			5*) printf 'Server Error: %s %s\n' \
				"$status_code" "$status_text" 1>&2; exit 1 ;;
		esac

		# Output response body.
		cat

		if [ -n "$next_url" ]; then
			_get "$next_url"
		fi
	}
}

open_in_browser() {
	coproc xdg-open "https://github.com/$1" 2>&1
	exec 1>&-
	exit 0
}

get_gh_repos() {
	(
		_get '/user/repos'
		_get '/user/starred'
		_get '/user/subscriptions'
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
