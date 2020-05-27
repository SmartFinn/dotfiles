#!/usr/bin/env bash

set -eo pipefail

reason="$3"

IFS=$'\n\t'
THIS_SCRIPT="${BASH_SOURCE[0]}"
RSYNC_EXCLUDE_FILE="$HOME/.cache/backintime/git_repos.exclude"
PROJECTS_DIRS=(
	"$HOME"
	# "$HOME/Git"
	# "$HOME/Development"
)

mapfile -d $'\0' -t GIT_REPOS < <(
	find "${PROJECTS_DIRS[@]}" -maxdepth 5 -type d -name '.git' -printf '%h\0'
)

staged_files() {
	git -C "$1" ls-files 2>/dev/null \
		| sed "s|^|$1/|" \
		| sort
}

unstaged_files() {
	git -C "$1" ls-files --exclude-standard --modified --others 2>/dev/null \
		| sed "s|^|$1/|" \
		| sort
}

generate_exclude_list_for_git_repo() {
	local git_dir="$1"

	# if has remotes
	git -C "$git_dir" remote | grep -q '.' || return 0
	# git -C "$git_dir" ls-remote -q &>/dev/null || return 0

	mapfile -d $'\0' -t files < <(
		git -C "$git_dir" ls-files -z --exclude-standard --others --modified 2>/dev/null
	)

	for file in "${files[@]}"; do
		file_path="$git_dir/$file"
		dir_path="${file_path%/*}"

		printf '1\t+ %s/\n' "${dir_path}"
		printf '2\t+ %s\n' "${file_path}"

		if [ "$dir_path" != "$git_dir" ]; then
			printf '3\t- %s/*\n' "${file_path%/*}"
		fi
	done | sort -u | cut -f 2-

	printf -- '- %s/*\n' "$git_dir"
	printf -- '- %s/\n'  "$git_dir"
}

generate_exclude_list() {
	cat <<- EOF
	# Created by $THIS_SCRIPT
	# $(date -R)

	EOF

	for git_repo in "${GIT_REPOS[@]}"; do
		# Header
		printf -- '\n# %s\n' "$git_repo"

		# Exclude staged files
		generate_exclude_list_for_git_repo "$git_repo"
	done
}

case "$reason" in
	1)  # Backup process begins
		mkdir -p "${RSYNC_EXCLUDE_FILE%/*}"
		rm -f "$RSYNC_EXCLUDE_FILE"
		generate_exclude_list > "$RSYNC_EXCLUDE_FILE"
		;;
	2)  # Backup process ends
		true
		;;
esac
