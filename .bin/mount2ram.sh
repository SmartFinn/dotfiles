#!/usr/bin/env bash
# This script binds directories from HOME directory that contain
# .mount2ram file to /tmp/mount2ram/PATH/TO/DIR

set -e -o pipefail

: "${M2R_PREFIX:=/tmp/mount2ram}"

case "$1" in
	unmount|umount)
		[ -f "$M2R_PREFIX/mtab" ] || exit 0

		while read -r mpoint; do
			mountpoint -q "$mpoint" || continue
			umount -l "$mpoint"
		done < "$M2R_PREFIX/mtab"

		rm -f "$M2R_PREFIX/mtab"
		;;
	mount)
		getent passwd | awk -F: '$3 >= 1000 && $3 < 60000 {print $(NF-1)}' |
			while read -r home_dir; do
				[ -d "$home_dir" ] || continue

				find "$home_dir" -maxdepth 5 -type f -name '.mount2ram' -printf '%h\n' |
					while read -r mpoint; do
						[ -d "$mpoint" ] || continue

						mkdir -p "$M2R_PREFIX/$mpoint"
						chown --reference="$mpoint" "$M2R_PREFIX/$mpoint"
						mount --bind "$M2R_PREFIX/$mpoint" "$mpoint"
						echo "$mpoint" >> "$M2R_PREFIX/mtab"
					done
			done
		;;
	*)
		echo "${0##*/} <mount|unmount>"
		exit 2
esac
