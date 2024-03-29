# zsh config file
# vim:ft=zsh

# ENVIRONMENT VARIABLES
# ---------------------
#
HISTSIZE=36000
SAVEHIST=30000
HISTFILE="${ZDOTDIR:-$HOME/.zsh}/history"
DIRSTACKSIZE=50
TMPPREFIX="${TMPPREFIX:-/tmp/zsh}"  # not a directory

# set cache dir for compatibility with oh-my-zsh plugins
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"

# customize colors for grep
export GREP_COLORS='mt=01;31:sl=:cx=:fn=34:ln=32:bn=32:se=2;37'

# support colors in less and man pages
export LESS='-iSRX --tabs=4'
export LESS_TERMCAP_mb=$'\e[01;35m'  # start blink
export LESS_TERMCAP_md=$'\e[01;32m'  # start bold
export LESS_TERMCAP_me=$'\e[0m'      # turn off bold, blink and underline
export LESS_TERMCAP_us=$'\e[33m'     # start underline
export LESS_TERMCAP_ue=$'\e[0m'      # stop underline
export LESS_TERMCAP_so=$'\e[47;30m'  # start standout (reverse)
export LESS_TERMCAP_se=$'\e[0m'      # stop standout

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
	# 	oh-my-zsh/plugins/dotenv
	# 	zsh-autosuggestions
	# 	zsh-completions
	# 	zsh-history-substring-search
	# 	zsh-syntax-highlighting
	# )
	#
	# zsh_load_plugins $plugins

	local plugin_entry
	local plugin_dir
	local plugin_name

	for plugin_entry ($@); do
		plugin_dir="${plugin_entry%:*}"
		plugin_name="${plugin_entry##*[/:]}"

		if [ -f "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin_dir/$plugin_name.plugin.zsh" ]; then
			source "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin_dir/$plugin_name.plugin.zsh"
		elif [ -f "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin_dir/$plugin_name.zsh" ]; then
			source "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin_dir/$plugin_name.zsh"
		elif [ -f "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin_dir/$plugin_name.sh" ]; then
			source "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin_dir/$plugin_name.sh"
		elif [ -f "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin_dir/$plugin_name" ]; then
			source "${ZDOTDIR:-$HOME/.zsh}/plugins/$plugin_dir/$plugin_name"
		else
			print "$funcstack[1]: Unable to load '$plugin_entry'." >&2
		fi
	done
}

function zsh_install_plugin() {
	# Usage:
	#
	# zsh_install_plugin plugin_name git_repo

	local repo_dir="${1%%/*}"
	local repo_url="$2"

	[ -d "${ZDOTDIR:-$HOME/.zsh}/plugins/$repo_dir" ] && return 0
	[ "$repo_url" = "local" ] && return 0

	git clone --depth 1 "$repo_url" "${ZDOTDIR:-$HOME/.zsh}/plugins/$repo_dir"
}

function zsh_update_plugins() {
	local plugin_dir

	for plugin_dir (${ZDOTDIR:-$HOME/.zsh}/plugins/*(N/)); do
		[ -d "$plugin_dir/.git" ] || continue
		print "$plugin_dir:t:" $(
			git -C "$plugin_dir" pull --rebase --recurse-submodules -j$(ulimit -n) 2>&1
		)
	done
}

# EXTERNAL
# --------
#
# Used to defer compinit/compdef
typeset -a __deferred_compdefs
compdef() { __deferred_compdefs=($__deferred_compdefs "$*") }

# import configuration from ~/.zsh directory
for rcfile (${ZDOTDIR:-$HOME/.zsh}/zshrc.d/??_*(N^/)); do
	source "$rcfile"
done

unset rcfile

# COMPLETIONS
# -----------
#
# Adding a XDG directory to fpath
if [ -d "${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions" ]; then
	fpath=("${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions" $fpath)
fi

# Load the compinit module. This will readefine the `compdef` function to
# the one that actually initializes completions.

autoload -Uz compinit

# On slow systems, checking the cached zcompdump file to see if it must be
# regenerated adds a noticable delay to zsh startup. This little hack restricts
# it to once a day. It should be pasted into your own completion file.
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than
#       throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.

if [[ -n "${TMPPREFIX}_zcompdump-${HOST:-localhost}-${ZSH_VERSION}"(#qN.mh+24) ]]; then
	compinit -d "${TMPPREFIX}_zcompdump-${HOST:-localhost}-${ZSH_VERSION}"
	{ zcompile "${TMPPREFIX}_zcompdump-${HOST:-localhost}-${ZSH_VERSION}" } &!
else
	compinit -C -d "${TMPPREFIX}_zcompdump-${HOST:-localhost}-${ZSH_VERSION}"
fi

# Apply all `compinit`s that have been deferred.
for cdef in "${__deferred_compdefs[@]}"; do
	compdef "${(fs/ /)cdef}"
done

unset cdef __deferred_compdefs
