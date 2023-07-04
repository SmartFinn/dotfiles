#!/usr/bin/env bash
# Generate list of local git repositories and uncommitted files
# in rsync exclude file format

set -eo pipefail

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"

: "${FIND_MAX_DEPTH:=6}"
: "${FIND_DIRS:=$HOME:$XDG_CONFIG_HOME:$XDG_DATA_HOME}"
: "${RSYNC_EXCLUDE_FILE:=$XDG_CACHE_HOME/backintime/git_repos.exclude}"
: "${GIT_REPOS_RESTORE_SCRIPT:=$HOME/.local/var/backup/git_repos_restore.sh}"

reason="$3"

case "$reason" in
	1)  # Backup process begins
		true
		;;
	*)  # Backup process ends
		exit 0
		;;
esac

IFS=$'\n\t'
THIS_SCRIPT="${BASH_SOURCE[0]}"

IFS=: read -ra dirs_array <<< "$FIND_DIRS"

mapfile -d $'\0' -t GIT_REPOS < <(
	find "${dirs_array[@]}" -maxdepth "$FIND_MAX_DEPTH" -type d -name '.git' -printf '%h\0'
)

generate_exclude_list_for_git_repo() {
	local git_dir="$1"
	local -a uncommitted_files
	local -a path_components
	local -i i j

	# if has remotes
	test -n "$(git -C "$git_dir" remote)" || return 0

	mapfile -d $'\0' -t uncommitted_files < <(
		git -C "$git_dir" ls-files -z --exclude-standard --others --modified 2>/dev/null
	)

	# add git-crypt keys to uncommitted files
	if [ -d "$git_dir/.git/git-crypt/keys" ]; then
		for key in "$git_dir/.git/git-crypt/keys"/*; do
			uncommitted_files+=(".git/git-crypt/keys/${key##*/}")
		done
	fi

	# exclude whole git repo if array is empty
	if [ "${#uncommitted_files[@]}" -eq 0 ]; then
		printf -- '- %s/\n' "$git_dir"
		return 0
	fi

	for uncommitted_file in "${uncommitted_files[@]}"; do
		# Convert relative path to uncommitted file into bash array
		IFS=/ read -ra path_components <<< "$uncommitted_file"

		# for each path components except the last one
		for ((i = 0; i < ${#path_components[@]} - 1; i++)) {
			for ((j = 0; j <= i; j++)) {
				subdir="${subdir:+$subdir/}${path_components[$j]}"
			}

			# cancel excluding subdirectory
			printf -- '1\t+ %s/\n' "$git_dir/$subdir"

			# exclude others files in the subdirectory
			printf -- '2\t- %s/*\n' "$git_dir/$subdir"

			unset subdir
		}

		# cancel excluding of uncommited files
		printf -- '1\t+ %s\n' "$git_dir/$uncommitted_file"
	done | sort -u | cut -f 2-  # remove duplicate lines

	# exclude files in git work tree
	printf -- '- %s/*\n' "$git_dir"
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

generate_commands_for_restore_git_repo() {
	local git_dir="$1"
	local -a git_remotes
	local git_remote_name git_remote_url

	# if has remotes
	test -n "$(git -C "$git_dir" remote)" || return 0

	mapfile -d $'\n' -t git_remotes < <(
		git -C "$git_dir" remote show -n 2>/dev/null
	)

	# exclude whole git repo if array is empty
	if [ "${#git_remotes[@]}" -eq 0 ]; then
		return 0
	fi

	printf -- '\n# %s\n' "$git_dir"
	printf 'if [ ! -d "%s/.git" ]; then\n' "$git_dir"
	printf -- '\tmkdir -vp "%s"\n' "$git_dir"
	printf -- '\tgit -C "%s" init\n' "$git_dir"

	for git_remote_name in "${git_remotes[@]}"; do
		git_remote_url="$(git -C "$git_dir" remote get-url "$git_remote_name")"
		printf -- '\tgit -C "%s" remote add %s %s\n' \
			"$git_dir" "$git_remote_name" "$git_remote_url"
	done

	printf -- '\tgit -C "%s" fetch --all\n' "$git_dir"
	printf -- '\tgit -C "%s" switch %s\n' "$git_dir" \
		"$(git -C "$git_dir" rev-parse --abbrev-ref HEAD)"
	printf 'fi\n'
}

generate_restore_script() {
	cat <<- EOF
	#!/usr/bin/env bash
	# Created by $THIS_SCRIPT
	# $(date -R)

	EOF

	for git_repo in "${GIT_REPOS[@]}"; do
		generate_commands_for_restore_git_repo "$git_repo"
	done
}

mkdir -p "${RSYNC_EXCLUDE_FILE%/*}"
rm -f "$RSYNC_EXCLUDE_FILE"
generate_exclude_list > "$RSYNC_EXCLUDE_FILE"

mkdir -p "${GIT_REPOS_RESTORE_SCRIPT%/*}"
rm -f "$GIT_REPOS_RESTORE_SCRIPT"
generate_restore_script | sed "s%$HOME%\$HOME%g" > "$GIT_REPOS_RESTORE_SCRIPT"
