#!/bin/sh

path_missing() {
	# usage: path_missing "$PATH" "/usr/local/bin"
	case ":$1:" in
		*:"${2%/}":*)
			false
			;;
		*)
			true
	esac
}

test_glob() {
	# usage: test_glob ":$PATH:" "*:/usr/bin:*"
	case "$1" in
		$2) true ;;
		*) false ;;
	esac
}

for i in "${XDG_CONFIG_HOME:-$HOME/.config}"/shell.d/??_*.sh; do
	if [ -r "$i" ]; then
		. "$i"
	fi
done

unset i
unset -f path_missing
unset -f test_glob
