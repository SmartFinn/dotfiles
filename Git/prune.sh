#!/usr/bin/env bash

# Cleanup unnecessary files and optimize the nested repositories

set -euo pipefail

IFS=$'\n\t'

readonly THIS_SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"
readonly SCRIPT_DIR="$(dirname "$THIS_SCRIPT")"

find "$SCRIPT_DIR" -maxdepth 3 -type d -name '.git' -printf '%h\0' |
	while read -d $'\0' -r git_repo; do
		count_sub=$(find "$git_repo/.git/objects" -maxdepth 1 -type d -name '??' | wc -l)
		if [ "$count_sub" -gt 0 ]; then
			printf '=> \e[32;1m%s\e[0m\n' "Pruning '$git_repo' ..."
			git -C "$git_repo" reflog expire --all --expire=now
			git -C "$git_repo" gc --prune=now --aggressive
		fi
done
