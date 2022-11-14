#!/usr/bin/env bash

# This script runs git pull in parallel for all nested git repos.

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

set -euo pipefail

IFS=$'\n\t'

readonly THIS_SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"
readonly SCRIPT_DIR="$(dirname "$THIS_SCRIPT")"

: "${MAX_PROC:=$(nproc)}"

do_pull() {
	local repo_dir="$1"

	_message() { printf "=> \e[32;1m%s\e[0m\n" "$*" >&2; }
	_warning() { printf "=> \e[33;1m%s\e[0m\n" "$*" >&2; }

	_git_repo_has_upstream() {
		git -C "$1" remote get-url upstream >/dev/null 2>&1 || return 1
	}

	_git_repo_has_origin() {
		git -C "$1" remote get-url origin >/dev/null 2>&1 || return 1
	}

	_git_has_clean_index() {
		git -C "$1" update-index --refresh || return 1
		git -C "$1" diff-index --quiet HEAD || return 1
	}

	_git_get_main_branch() {
		git -C "$1" ls-remote --symref origin |
			awk '$3 == "HEAD" {print substr($2,12)}'
	}

	_message "Pulling '$repo_dir' ..."

	if ! _git_has_clean_index "$repo_dir"; then
		_warning "'$repo_dir': has uncommited changes. Skipping..."
		return 0
	fi

	main_branch="$(_git_get_main_branch "$repo_dir")"

	if _git_repo_has_upstream "$repo_dir"; then
		git -C "$repo_dir" fetch upstream
		git -C "$repo_dir" checkout "$main_branch" >/dev/null 2>&1
		git -C "$repo_dir" merge upstream/"$main_branch"
		git -C "$repo_dir" checkout - >/dev/null 2>&1
	elif _git_repo_has_origin "$repo_dir"; then
		git -C "$repo_dir" checkout "$main_branch" >/dev/null 2>&1
		git -C "$repo_dir" pull origin
		git -C "$repo_dir" checkout - >/dev/null 2>&1
	else
		_warning  "'$repo_dir': doesn't have tracked repositories. Skipping..."
	fi
}

export -f do_pull

# Disable multiplexed connections
export GIT_SSH_COMMAND="ssh -o ControlMaster=no"

command -v git >/dev/null || {
	echo "Error: 'git' command not found, please install it first."
	exit 1
}

if command -v parallel >/dev/null; then
	find "$SCRIPT_DIR" -maxdepth 3 -type d -name '.git' -printf '%h\0' |
		parallel -0 -P "$MAX_PROC" do_pull
else
	# fallback to xargs
	find "$SCRIPT_DIR" -maxdepth 3 -type d -name '.git' -printf '%h\0' |
		xargs -0 -I {} -P "$MAX_PROC" bash -c 'do_pull "$@"' _ {}
fi

exit 0
