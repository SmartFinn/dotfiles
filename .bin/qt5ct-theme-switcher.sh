#!/bin/sh

set -e

QT5CT_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/qt5ct"
CONFIG="$QT5CT_DIR/qt5ct.conf"
DAY_CONFIG="$QT5CT_DIR/qt5ct.light.conf"
NIGHT_CONFIG="$QT5CT_DIR/qt5ct.dark.conf"

if  [ ! -f "$NIGHT_CONFIG" ] ||
	[ ! -f "$DAY_CONFIG" ]; then
	echo "Unsupported configuration." >&2
	echo "Please create the following config before:" >&2
	echo " - '$DAY_CONFIG'" >&2
	echo " - '$NIGHT_CONFIG'" >&2
	exit 1
fi

switch_to_dark() {
	ln -sf "${NIGHT_CONFIG##*/}" "$CONFIG"
	echo "Switched to dark theme." >&2
}

switch_to_light() {
	ln -sf "${DAY_CONFIG##*/}" "$CONFIG"
	echo "Switched to light theme." >&2
}

auto_theme_swith() {
	current_theme="$(readlink "$CONFIG")"

	case "$current_theme" in
		*.dark.conf)
			switch_to_light
			;;
		*.light.conf)
			switch_to_dark
			;;
		*)
			echo "Error: unable detect current theme" >&2
			exit 1
	esac
}

case "$1" in
	light|day)
		switch_to_light
		;;
	dark|night)
		switch_to_dark
		;;
	*)
		auto_theme_swith
		;;
esac
