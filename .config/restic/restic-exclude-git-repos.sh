#!/usr/bin/env bash
# Generate list of local git repositories and uncommitted files
# in restic exclude file format

set -eo pipefail

IFS=$'\n\t'
THIS_SCRIPT="${BASH_SOURCE[0]}"
EXCLUDE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/restic/exclude-git-repos"
PROJECTS_DIRS=(
	"$HOME"
	"${XDG_DATA_HOME:-$HOME/.local}/share/"
)

mapfile -d $'\0' -t GIT_REPOS < <(
	find "${PROJECTS_DIRS[@]}" -maxdepth 5 -type d -name '.git' -printf '%h\0'
)

generate_exclude_list_for_git_repo() {
	local git_dir="$1"

	# if has remotes
	git -C "$git_dir" remote | grep -q '.' || return 0

	mapfile -d $'\0' -t files < <(
		git -C "$git_dir" ls-files -z --exclude-standard --others --modified 2>/dev/null
	)

	# exclude whole git repo if array is empty
	if [ "${#files[@]}" -eq 0 ]; then
		printf -- '%s\n' "$git_dir"
		return 0
	fi

	# exclude files in git work tree
	printf -- '%s/*\n' "$git_dir"

	for file in "${files[@]}"; do
		file_path="$git_dir/$file"
		dir_path="${file_path%/*}"

		if [ "$dir_path" != "$git_dir" ]; then
			# cancel excluding parent dir
			printf -- '!%s\n' "${dir_path}"
			# but exclude files in the dir
			printf -- '%s/*\n' "${dir_path}"
		fi

		# cancel excluding of non-commited files
		printf -- '!%s\n' "${file_path}"
	done | sort -u
}

generate_exclude_list() {
	cat <<- EOF
	# Created by $THIS_SCRIPT
	# $(date -R)

	EOF

	for git_repo in "${GIT_REPOS[@]}"; do
		# Title
		printf -- '\n# %s\n' "$git_repo"

		# Exclude staged files
		generate_exclude_list_for_git_repo "$git_repo"
	done
}

mkdir -p "${EXCLUDE_FILE%/*}"
rm -f "$EXCLUDE_FILE"
generate_exclude_list > "$EXCLUDE_FILE"
