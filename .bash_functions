command -v dtach >/dev/null &&
test -n "$XDG_RUNTIME_DIR" &&
dtach() {
	local socket="$XDG_RUNTIME_DIR/dtach.socket"

	printf 'Trying to attach to `%s`' "$socket"

	command dtach -A "$socket" -r winch "${SHELL:-/bin/bash}"
}

command -v dpkg >/dev/null &&
dpkg-purge-rc() {
	dpkg -l | awk '/^rc/ {print $2}' | xargs -r sudo dpkg --purge
}

command -v apt-mark >/dev/null &&
test -f /var/log/installer/initial-status.gz &&
list_installed_packages() {
	# returns list of packages installed by user
	# https://askubuntu.com/a/492343/565749
	comm -23 \
		<(apt-mark showmanual | sort -u) \
		<(gzip -dc /var/log/installer/initial-status.gz | awk '/Package/ {print $2}' | sort -u)
}

test -s /var/log/dpkg.log &&
apt-history() {
	# Parses dpkg log files to get package installation, removal, and rollback
	# information.
	#
	# Based on https://github.com/blyork/apt-history
	_logcat() {
		for file in /var/log/dpkg.log*; do
			[ -f "$file" ] || return 1
			case "$file" in
				*.log|*.log.1)
					cat "$file"
					;;
				*.gz)
					zcat "$file"
					;;
				*)
					printf '*** Invalid file: "%s" ***\n' "$file" >&2
					return 1
			esac
		done
	}

	logcat() {
		_logcat | sort -g
	}

	case "$1" in
		install|upgrade|remove)
			logcat | grep " $1 "
			;;
		rollback)
			logcat \
				| grep upgrade \
				| grep "$2" -A10000000 \
				| grep "$3" -B10000000 \
				| awk '{print $4"="$5}'
			;;
		*)
			logcat
	esac
}

# create a new directory and enter it
mkcd() { mkdir -p "$1" && cd "$1"; }

command -v docker >/dev/null &&
docker-ips() {
	docker container ls --quiet |
		xargs -n 1 docker inspect --format '{{.Name}}|{{range .NetworkSettings.Networks}}{{.IPAddress}}/{{.IPPrefixLen}}{{end}}' |
		awk -F'|' '
		BEGIN {printf "%20s %18s\n", "CONTAINER", "IP ADDRESS"}
		{printf "%20s %18s\n", substr($1,2,20), $2}
		'
}

if command -v pet >/dev/null; then
	function pet-select() {
		BUFFER=$(pet search --query "$READLINE_LINE")
		READLINE_LINE=$BUFFER
		READLINE_POINT=${#BUFFER}
	}
	bind -x '"\C-s": pet-select'
fi

if command -v ranger >/dev/null; then
	_ranger_cd() {
		tempfile="$(mktemp -u --tmpdir ranger_lastdir.XXXXXX)"
		ranger --choosedir="$tempfile" "${@:-$PWD}"

		if [ -f "$tempfile" ]; then
			builtin cd -- "$(<"$tempfile")" || return
			command rm -f -- "$tempfile"
		fi
	}

	# Ctrl-] - change current directory with ranger
	bind '"\C-]": "_ranger_cd\C-m"'

	# ranger - Smart alias
	ranger() {
		[ -z "$RANGER_LEVEL" ] || exit
		command ranger "$@"
	}

	# Alt+j / Esc j - run ranger
	bind -x '"\ej": ranger'

fi

command -v zoxide >/dev/null && eval "$(zoxide init bash)"

__run_if_exists() {
	# run command if it exists
	local -a saved_cmd=("$@")

	case "$1" in
		sudo) shift 1 ;;
	esac

	if command -v "$1" >/dev/null; then
		echo -e "\e[1;32m =>\e[0m" "${saved_cmd[@]}" >&2
		"${saved_cmd[@]}"
	fi
}

up2date() {
	# Debian/Ubuntu
	__run_if_exists sudo apt update
	__run_if_exists sudo apt dist-upgrade -Vy

	# ArchLinux/Manjaro
	__run_if_exists sudo pacman -Syu --noconfirm

	# RHEL/Fedora
	__run_if_exists sudo dnf --refresh update -y

	# snap
	__run_if_exists sudo snap refresh

	# Flatpak (system-wide)
	__run_if_exists sudo flatpak --system update --appstream
	__run_if_exists sudo flatpak --system update -y
	__run_if_exists sudo flatpak --system uninstall --unused -y

	# Flatpak (user)
	__run_if_exists flatpak --user update --appstream
	__run_if_exists flatpak --user update -y
	__run_if_exists flatpak --user uninstall --unused -y

	# pipx
	__run_if_exists pipx upgrade-all

	# sdd
	__run_if_exists sdd upgrade

	# NPM
	__run_if_exists ncu -g
}



# vim:ft=sh:ts=4:sw=4
