#!/usr/bin/env bash

set -eo pipefail

. "$HOME/.profile"

dest_dir="$HOME/.local/var/backup/packages"

get_user_installed_packages() {
	# returns list of packages installed by user
	# https://askubuntu.com/a/492343/565749

	command -v apt-mark >/dev/null || return 0
	test -f /var/log/installer/initial-status.gz || return 0

	comm -23 \
		<(apt-mark showmanual | sort -u) \
		<(gzip -dc /var/log/installer/initial-status.gz \
			| awk '/Package/ {print $2}' | sort -u) > "$dest_dir/apt-packages.list"
}

get_apt_manual_installed_packages() {
	command -v apt >/dev/null || return 0
	apt list --manual-installed > "$dest_dir/apt-manual-installed-packages.list"
}

get_installed_gems() {
	command -v gem >/dev/null || return 0
	gem list > "$dest_dir/ruby-gems.list"
}

get_user_installed_python2_packages() {
	command -v python2 >/dev/null || return 0
	python2 -m pip -V >/dev/null || return 0
	python2 -m pip list --user --format=freeze > "$dest_dir/python2-packages.list"
}

get_user_installed_python3_packages() {
	command -v python3 >/dev/null || return 0
	python3 -m pip -V >/dev/null || return 0
	python3 -m pip list --user --format=freeze > "$dest_dir/python3-packages.list"
}

get_pipx_venvs() {
	command -v pipx >/dev/null || return 0
	pipx list --short > "$dest_dir/pipx-venv.list"
}

get_installed_flatpak_apps() {
	command -v flatpak >/dev/null || return 0
	env XDG_DATA_DIRS="$HOME"/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share \
		flatpak list --app --columns=installation,ref > "$dest_dir/flatpak_apps.list"
	env XDG_DATA_DIRS="$HOME"/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share \
		flatpak remotes --columns=name,url > "$dest_dir/flatpak_remotes.list"
	env XDG_DATA_DIRS="$HOME"/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share \
		flatpak override --show > "$dest_dir/flatpak_overrides.list"
}

get_installed_npm_packages() {
	command -v npm >/dev/null || return 0
	npm list -g --depth=0 > "$dest_dir/npm_packages.list"
}

get_installed_snaps() {
	command -v snap >/dev/null || return 0
	snap list --color=never > "$dest_dir/snaps.list"
}

get_installed_rpm_packages() {
	command -v rpm >/dev/null || return 0
	rpm -qa --queryformat "%{NAME}\t%{VERSION}\n" | sort | column -t > "$dest_dir/rpm-packages.list"
}

get_installed_sdd_apps() {
	command -v sdd >/dev/null || return 0
	sdd list --installed > "$dest_dir/sdd-apps.list"
}

rm -rf "$dest_dir"
mkdir -p "$dest_dir"

get_user_installed_packages
get_apt_manual_installed_packages
get_installed_gems
get_user_installed_python2_packages
get_user_installed_python3_packages
get_pipx_venvs
get_installed_flatpak_apps
get_installed_npm_packages
get_installed_snaps
get_installed_rpm_packages
get_installed_sdd_apps
