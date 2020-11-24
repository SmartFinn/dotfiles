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

export QT_QPA_PLATFORMTHEME="qt5ct"
export TDESKTOP_DISABLE_TRAY_COUNTER=1

export EDITOR="nvim"
export SUDO_EDITOR="vim"
export VISUAL="nvim"
export WORDCHARS='*?[]~=/&;!|#$%^(){}<>'

export DEBFULLNAME="Sergei Eremenko"
export DEBEMAIL="finalitik@gmail.com"

#export GPGKEY=DAF1B4B5	# sergei@eremenko.pp.ua
export GPGKEY=9D2E78EC	# finalitik@gmail.com

GITHUB_TOKEN="$(secret-tool lookup github_api token)"; export GITHUB_TOKEN
export GH_TOKEN="$GITHUB_TOKEN"
export GHI_TOKEN="$GITHUB_TOKEN"
export PET_GITHUB_ACCESS_TOKEN="$GITHUB_TOKEN"

WA_APPID="$(secret-tool lookup wolframalpha_api appid)"; export WA_APPID
GITEA_TOKEN="$(secret-tool lookup gitea_api token)"; export GITEA_TOKEN

HITBTC_PUBLIC_KEY="$(secret-tool lookup hitbtc_api public_key)"; export HITBTC_PUBLIC_KEY
HITBTC_SECRET_KEY="$(secret-tool lookup hitbtc_api secret_key)"; export HITBTC_SECRET_KEY

TINYPNG_API_KEY="$(secret-tool lookup tinypng_api api_key)"; export TINYPNG_API_KEY

export SHELLCHECK_OPTS='--exclude=SC1091 --exclude=SC1117'
export FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border'
export DOTBARE_DIR="$HOME/.local/var/dotbare"

# ranger: ignore config file placed in /etc/ranger
# export RANGER_LOAD_DEFAULT_RC="FALSE"

if [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/lf/lf_icons.sh" ]; then
	. "${XDG_CONFIG_HOME:-$HOME/.config}/lf/lf_icons.sh"
fi
