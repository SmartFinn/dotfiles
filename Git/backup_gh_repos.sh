#!/usr/bin/env bash

# Backup repositories in parallel from your GitHub account to the current
# directory with ORG_NAME/REPO_NAME structure.
#
# Requirements
# ------------
# * curl
# * awk | mawk
#
# Setup
# -----
# Generate access token https://github.com/settings/tokens/new?scopes=repo
# on GitHub Account Settings -> Developer settings -> Personal access tokens.
#
# Add authentication credentials to a `$HOME/.netrc` file:
#
#     machine github.com
#         login <username>
#         password <token>
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

set -euo pipefail

IFS=$'\n\t'

readonly THIS_SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"
readonly SCRIPT_DIR="$(dirname "$THIS_SCRIPT")"

_get_clone_urls() {
	curl -ns https://api.github.com/user/repos |
		awk '/clone_url/ {gsub(/[",]/, X); print $2;}'
}

do_clone() {
	local url="$1"
	local owner_name repo_name repo_dir

	owner_name="$(basename "${url%/*}")"
	repo_name="${url##*/}"
	repo_dir="$BACKUP_DIR/$owner_name/$repo_name"

	if [ -d "$repo_dir" ]; then
		git -C "$repo_dir" remote update
	else
		git clone --mirror "$url" "$repo_dir"
	fi
}

export -f do_clone

# Disable multiplexed connections
export GIT_SSH_COMMAND="ssh -o ControlMaster=no"

export BACKUP_DIR="${1:-$SCRIPT_DIR}"

[ -d "$BACKUP_DIR" ] || mkdir -p "$BACKUP_DIR"

if command -v parallel > /dev/null; then
	_get_clone_urls | parallel do_clone
else
	_get_clone_urls |
		xargs -I {} -P "$(nproc)" bash -c 'do_clone "$@"' _ {}
fi

exit 0
