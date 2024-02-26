#!/usr/bin/env bash

# Run tasks to optimize Git repository data, speeding up other Git
# commands and reducing storage requirements for the repository.

set -euo pipefail

IFS=$'\n\t'

readonly THIS_SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"
readonly SCRIPT_DIR="$(dirname "$THIS_SCRIPT")"

find "$SCRIPT_DIR" -maxdepth 3 -type d -name '.git' -printf '%h\0' |
	while read -d $'\0' -r git_repo; do
		printf '=> \e[32;1m%s\e[0m\n' "Running on '$git_repo' ..."
		git -C "$git_repo" maintenance run
done
