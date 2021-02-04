# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash -l include .bashrc if it exists
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && [ -n "$PS1" ]; then
	. "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# load variables with sensitive values
[ -r "$HOME/.secrets" ] && . "$HOME/.secrets"

if command -v vim >/dev/null; then
	export EDITOR=vim
fi

if command -v less >/dev/null; then
	export PAGER=less
fi

if command -v fzf >/dev/null; then
	export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border'
fi

if command -v dotbare >/dev/null; then
	export DOTBARE_DIR="$HOME/.local/var/dotbare"
fi

if [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/lf/lf_icons.sh" ]; then
	. "${XDG_CONFIG_HOME:-$HOME/.config}/lf/lf_icons.sh"
fi

if command -v tmux >/dev/null; then
	if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
		exec tmux new -As ${HOSTNAME:-SSH}
	fi
fi

# vim:ft=sh:ts=4:sw=4
