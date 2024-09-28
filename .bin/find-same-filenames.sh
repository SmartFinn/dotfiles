#!/usr/bin/env bash
# Recursively find files with the same basename
#
# Usage: find-same-filenames.sh [DIR ...]

find "$@" -type f -exec bash -c 'printf "%q\0" "$@"' {} + |
awk -F/ 'BEGIN { RS="\0" } {
	file_name=$NF;

	if (count[file_name] >= 1) {
		filelist[file_name]=filelist[file_name] "\n" $0;
	} else {
		filelist[file_name]=$0;
	}

	count[file_name]++;
}

END {
	for (file_name in filelist) {
		if (count[file_name] > 1) {
			print filelist[file_name];
			print "\n";
		}
	}
}'
