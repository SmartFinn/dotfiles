command -v nvim >/dev/null || return 0

if ! command -v vim >/dev/null; then
	alias vim="NVIM_APPNAME=vim nvim"
fi

if [ -d "${XDG_CONFIG_HOME:-$HOME/.config}/astronvim" ]; then
	alias astronvim="NVIM_APPNAME=astronvim nvim"
fi
