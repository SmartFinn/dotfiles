# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# when running bash -l include .bashrc if it exists
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && [ -n "$PS1" ]; then
	. "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
# [ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
# [ -d "$HOME/.bin" ] && PATH="$HOME/.bin:$PATH"

# set PATH so it includes user's private bin if it exists
# [ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

if [ -f "$HOME/.config/profile.d/init.sh" ]; then
	. "$HOME/.config/profile.d/init.sh"
fi

export EDITOR="nvim"
export SUDO_EDITOR="vim"
export VISUAL="nvim"
export WORDCHARS='*?[]~=/&;!|#$%^(){}<>'

export SHELLCHECK_OPTS='--exclude=SC1091 --exclude=SC1117'
export DOTBARE_DIR="$HOME/.local/var/dotbare"
export GNOME_SETUP_DISPLAY=${DISPLAY:-:0}
