command -v dtach >/dev/null &&
dtach() {
	local id="${1:-0}"
	local command="${SHELL:-/bin/bash}"
	local socket="/tmp/dtach${id}.socket"

	printf 'Trying to attach to `%s`' "$socket"

	command dtach -A "$socket" -r winch "$command"
}

command -v apt-mark >/dev/null &&
list_installed_packages() {
	# returns list of packages installed by user
	# https://askubuntu.com/a/492343/565749
	comm -23 \
		<(apt-mark showmanual | sort -u) \
		<(gzip -dc /var/log/installer/initial-status.gz | awk '/Package/ {print $2}' | sort -u)
}

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
			builtin cd -- "$(<"$tempfile")"
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
	__run_if_exists sudo apt update
	__run_if_exists sudo apt dist-upgrade -Vy
	__run_if_exists sudo pacman -Syu --noconfirm
	__run_if_exists sudo dnf --refresh update -y
	__run_if_exists sudo snap refresh
	__run_if_exists flatpak update -y
	__run_if_exists pipx upgrade-all
	__run_if_exists sdd upgrade
	__run_if_exists ncu -g
}



# vim:ft=sh:ts=4:sw=4
