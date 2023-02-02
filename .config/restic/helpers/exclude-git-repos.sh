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
	local -a uncommitted_files
	local -a path_components
	local -i i j

	# if has remotes
	git -C "$git_dir" remote | grep -q '.' || return 0

	mapfile -d $'\0' -t uncommitted_files < <(
		git -C "$git_dir" ls-files -z --exclude-standard --others --modified 2>/dev/null
	)

	# exclude whole git repo if array is empty
	if [ "${#uncommitted_files[@]}" -eq 0 ]; then
		printf -- '%s\n' "$git_dir"
		return 0
	fi

	# exclude files in git work tree
	printf -- '%s/*\n' "$git_dir"

	for uncommitted_file in "${uncommitted_files[@]}"; do
		# Convert relative path to uncommitted file into bash array
		IFS=/ read -ra path_components <<< "$uncommitted_file"

		# for each path components except the last one
		for ((i = 0; i < ${#path_components[@]} - 1; i++)) {
			for ((j = 0; j <= i; j++)) {
				subdir="${subdir:+$subdir/}${path_components[$j]}"
			}

			# cancel excluding subdirectory
			printf -- '!%s\n' "$git_dir/$subdir"

			# but exclude files in the subdirectory
			printf -- '%s/*\n' "$git_dir/$subdir"

			unset subdir
		}

		# cancel excluding of uncommited files
		printf -- '!%s\n' "$git_dir/$uncommitted_file"
	done | awk '!(count[$0]++)'  # remove duplicate lines
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
