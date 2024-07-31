# Clean-up home dir
# https://wiki.archlinux.org/index.php/XDG_Base_Directory

# export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-HOME/.config}"
# export XDG_CACHE_HOME="$HOME/.cache"
# export XDG_DATA_HOME="$HOME/.local/share"
# export XDG_STATE_HOME="$HOME/.local/state"

export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export LESSHISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/lesshst"
export HTTPIE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/httpie"
export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/ipython"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"
export PARALLEL_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/parallel"
export PYLINTHOME="${XDG_CACHE_HOME:-$HOME/.cache}/pylint"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wine"
export ANSIBLE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/ansible"
export MYCLI_HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/mycli-history"
export NODE_REPL_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}/node_repl_history"
export REDISCLI_HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/rediscli_history"
export SQLITE_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}/sqlite_history"
export DOTNET_CLI_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/dotnet"
