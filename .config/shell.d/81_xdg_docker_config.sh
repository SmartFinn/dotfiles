command -v docker >/dev/null || return 0

export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"
