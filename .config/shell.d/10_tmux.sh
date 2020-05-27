command -v tmux >/dev/null || return 0

alias tmux='tmux -f "${XDG_CONFIG_HOME:-$HOME/.config}"/tmux/tmux.conf'
