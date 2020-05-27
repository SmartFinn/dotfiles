#!/bin/sh

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
unset -f test_glob
