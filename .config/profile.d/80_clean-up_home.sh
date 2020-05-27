# Clean-up home dir
# https://wiki.archlinux.org/index.php/XDG_Base_Directory

# export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-HOME/.config}"
# export XDG_CACHE_HOME="$HOME/.cache"
# export XDG_DATA_HOME="$HOME/.local/share"

export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export LESSHISTFILE="-"
export HTTPIE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/httpie"
export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/ipython"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"
export PARALLEL_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/parallel"
export PYLINTHOME="${XDG_CACHE_HOME:-$HOME/.cache}/pylint"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wine"
