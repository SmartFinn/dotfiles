#!/usr/bin/env bash

# Clone repositories from your GitHub account to the current directory with
# ORG_NAME/REPO_NAME structure (or without).
#
# Requirements
# ------------
# * curl
# * jq
#
# Setup
# -----
# Generate access token https://github.com/settings/tokens/new?scopes=repo
# on GitHub Account Settings -> Developer settings -> Personal access tokens.
#
# Add authentication credentials to a `$HOME/.netrc` file:
#
#     machine api.github.com
#         login <username>
#         password <token>
#
# Restrict permissions on that file with `chmod 600 ~/.netrc`!

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

readonly THIS_SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"
readonly PROGNAME="$(basename "$THIS_SCRIPT")"

_message() { printf "=> \e[32;1m%s\e[0m\n" "$*" >&2; }
_warning() { printf "=> \e[33;1m%s\e[0m\n" "$*" >&2; }

usage() {
	cat >&2 <<- EOF
	usage:
	  $PROGNAME [OPTIONS]

	OPTIONS:
	  -a --all         include archived repositories
	  -f --flatten     remove USER and ORG from repository path
	  -i --ignore      do not clone the specified repository
	  -n --dry-run     just print the commands that would be executed
	  -h --help        show this help
	EOF

	exit "${1:-0}"
}

_run() {
	if (( DRY_RUN )); then
		echo "$@"
		return 0
	fi

	"$@"
}

_get_repos() {
	curl -ns https://api.github.com/user/repos |
		jq -r '.[] | [.full_name, .ssh_url, .fork, .archived] | @tsv'
}

_get_upstream() {
	local full_name="$1"

	curl -ns "https://api.github.com/repos/$full_name" |
		jq -r '.source.ssh_url'
}

_in_array() {
	local item="$1"
	local -a list=( "${@:2}" )
	local i

	for i in "${list[@]}"; do
		if [[ $i == "$item" ]]; then
			return 0
		fi
	done

	return 1
}

: "${ALL:=0}"
: "${FLATTEN:=0}"
: "${DRY_RUN:=0}"

IGNORE_LIST=()

params="$(getopt -o afhi:n -l flatten,help,ignore:,dry-run --name "$PROGNAME" -- "$@")"

eval set -- "$params"

while true; do
	case "$1" in
		-a|--all)
			ALL=1
			shift 1
			;;
		-f|--flatten)
			FLATTEN=1
			shift 1
			;;
		-h|--help)
			shift 1
			usage 0
			;;
		-i|--ignore)
			IGNORE_LIST+=("$2")
			shift 2
			;;
		-n|--dry-run)
			DRY_RUN=1
			shift 1
			;;
		--)
			shift 1
			break
			;;
		*)
			echo "Not implemented: $1" >&2
			usage 2
	esac
done

# Return an error if any positional parameters are found
if [ -n "$1" ]; then
	echo "illegal parameter -- '$1'" >&2
	usage 2
fi

_get_repos | while read -r full_name url fork archived; do
	name="${full_name#*/}"

	if [[ $ALL -eq 0 ]] && [[ $archived == true ]]; then
		continue
	fi

	if (( FLATTEN )); then
		repo_dir="$name"
	else
		repo_dir="$full_name"
	fi

	# skip if directory exists
	[ -d "$repo_dir/.git" ] && continue

	# skip if in IGNORE_LIST
	if _in_array "$full_name" "${IGNORE_LIST[@]}" ||
		_in_array "$name" "${IGNORE_LIST[@]}"; then
			_warning "Skip '$full_name' because found in the ignore list."
			continue
	fi

	_message "Cloning '$full_name' ..."
	_run git clone "$url" "$repo_dir"

	if [[ $fork == true ]]; then
		upstream="$(_get_upstream "$full_name")"
		_run git -C "$repo_dir" remote add upstream "$upstream"
	fi
done

exit 0
