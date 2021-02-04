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

# vim:ft=sh:ts=4:sw=4
