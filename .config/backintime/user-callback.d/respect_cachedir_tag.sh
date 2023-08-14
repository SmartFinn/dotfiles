#!/usr/bin/env bash
# Generate list of directories with CACHEDIR.TAG files
# in rsync exclude file format

set -eo pipefail

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"

: "${FIND_MAX_DEPTH:=6}"
: "${FIND_DIRS:=$HOME:$XDG_CONFIG_HOME:$XDG_DATA_HOME}"
: "${RSYNC_EXCLUDE_FILE:=$XDG_CACHE_HOME/backintime/cachedir.exclude}"

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

mapfile -d $'\0' -t CACHEDIRS < <(
	find "${dirs_array[@]}" -maxdepth "$FIND_MAX_DEPTH" -type f -name 'CACHEDIR.TAG' -printf '%h\0'
)

generate_exclude_list() {
	cat <<- EOF
	# Created by $THIS_SCRIPT
	# $(date -R)

	EOF

	for cachedir in "${CACHEDIRS[@]}"; do
		printf -- '- %s\n' "$cachedir"
	done | sort -u
}

mkdir -p "${RSYNC_EXCLUDE_FILE%/*}"
rm -f "$RSYNC_EXCLUDE_FILE"
generate_exclude_list > "$RSYNC_EXCLUDE_FILE"
