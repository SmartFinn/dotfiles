# zsh config file
# vim:ft=zsh

# ENVIRONMENT VARIABLES
# ---------------------
#
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${ZDOTDIR:-$HOME/.zsh}/history"
DIRSTACKSIZE=50
TMPPREFIX="${TMPPREFIX:-/tmp/zsh}"  # not a directory

# enable colors for ls and grep
export LS_OPTIONS='--color=auto'
# export GREP_OPTIONS='--color=auto'
export GREP_COLOR='7;49;33'

# support colors in less and man pages
export LESS='-iSRX --tabs=4'
export LESS_TERMCAP_mb=$'\e[01;35m'
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[47;30m'
export LESS_TERMCAP_se=$'\e[0m'

# load zsh/nearcolor if 24-bit colors aren't supported
if [[ "$COLORTERM" != (24bit|truecolor) && "${terminfo[colors]}" -ne 16777216 ]]; then
	zmodload zsh/nearcolor
fi

# to use the colors from the file ~/.dircolors if it exists,
# otherwise use the default color
for dircolors (
	"$HOME/.dircolors${terminfo[colors]}"
	"$HOME/.dircolors"
); do
	[ -r "$dircolors" ] || continue
	eval $(dircolors -b $dircolors) || eval $(dircolors -b)
	break
done
unset dircolors

# unexport FPATH to avoid duplication in subshell
typeset +x FPATH

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

# EXTENSIONS
# ----------
#
# edit the command line using the visual editor, like in bash
autoload -Uz edit-command-line
zle -N edit-command-line

# handling urls with url-quote-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# bashquese Ctrl-W
autoload -Uz select-word-style
select-word-style bash

# a simple way of adding or removing hooks
autoload -Uz add-zsh-hook

# disable ^S and ^Q mapping
# stty start undef
# stty stop undef

# OPTIONS
# -------
#
ZSH_OPTIONS=(
	# Changing Directories
	AUTO_CD
	AUTO_PUSHD
	CDABLE_VARS
	PUSHD_IGNORE_DUPS
	PUSHD_MINUS
	PUSHD_SILENT

	# Completion
	NO_AUTO_REMOVE_SLASH
	COMPLETE_ALIASES
	COMPLETE_IN_WORD
	GLOB_COMPLETE
	# HASH_LIST_ALL
	LIST_ROWS_FIRST

	# Expansion and Globbing
	EXTENDED_GLOB
	GLOB_DOTS
	NUMERIC_GLOB_SORT

	# History
	HIST_EXPIRE_DUPS_FIRST
	HIST_FIND_NO_DUPS
	HIST_IGNORE_ALL_DUPS
	HIST_IGNORE_SPACE
	HIST_REDUCE_BLANKS
	HIST_SAVE_NO_DUPS
	# INC_APPEND_HISTORY
	SHARE_HISTORY

	# Input/Output
	NO_CLOBBER
	CORRECT_ALL
	NO_FLOW_CONTROL
	INTERACTIVE_COMMENTS

	# Job Control
	NO_BG_NICE
	NO_CHECK_JOBS
	NO_HUP

	# Prompting
	PROMPT_SUBST
	TRANSIENT_RPROMPT

	# Zle
	NO_BEEP
)
setopt $ZSH_OPTIONS

# PLUGINS
# -------
#
function zsh_load_plugins() {
	# Usage:
	#
	# plugins=(
	# 	zsh-autosuggestions
	# 	zsh-completions
	# 	zsh-history-substring-search
	# 	zsh-syntax-highlighting
	# )
	#
	# zsh_load_plugins $plugins

	local plugin

	for plugin ($@); do
		if [ -r "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin/$plugin.plugin.zsh" ]; then
			source "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin/$plugin.plugin.zsh"
		elif [ -r "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin/$plugin.zsh" ]; then
			source "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin/$plugin.zsh"
		elif [ -r "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin/$plugin.sh" ]; then
			source "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin/$plugin.sh"
		elif [ -r "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin/$plugin.zsh-theme" ]; then
			source "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin/$plugin.zsh-theme"
		else
			echo "$funcstack[1]: Unable to load '$plugin'." >&2
		fi
	done
}

function zsh_update_plugins() {
	local plugin

	for plugin (${ZDOTDIR:-$HOME/.zsh}/plugins/*(N/)); do
		git -C "$plugin" rev-parse --is-inside-work-tree >/dev/null 2>&1 || continue
		printf '%s: ' "$plugin:t"
		git -C "$plugin" pull 2>/dev/null || echo "Unable to upgrade."
	done
}

# EXTERNAL
# --------
#
# Used to defer compinit/compdef
typeset -a __compdefs
compdef() { __compdefs=($__compdefs "$*") }

# import configuration from ~/.zsh directory
for rcfile (${ZDOTDIR:-$HOME/.zsh}/zshrc.d/??_*(N^/)); do
	source "$rcfile"
done

unset rcfile

# COMPLETIONS
# -----------
#
# Load the compinit module. This will readefine the `compdef` function to
# the one that actually initializes completions.
# https://github.com/zsh-users/antigen
autoload -Uz compinit

if [[ -n "${TMPPREFIX}_zcompdump-${HOST:-localhost}-${ZSH_VERSION}"(N.mh+24) ]]; then
	compinit -d "${TMPPREFIX}_zcompdump-${HOST:-localhost}-${ZSH_VERSION}"
	{ zcompile "${TMPPREFIX}_zcompdump-${HOST:-localhost}-${ZSH_VERSION}" } &!
else
	compinit -C -d "${TMPPREFIX}_zcompdump-${HOST:-localhost}-${ZSH_VERSION}"
fi

# Apply all `compinit`s that have been deferred.
for cdef in "${__compdefs[@]}"; do
	compdef "${(fs/ /)cdef}"
done

unset cdef __compdefs
