# if not running interactively, don't do anything
case $- in
	*i*) true ;;
	*) return ;;
esac

shopt -s autocd        # change to named directory
shopt -s cdable_vars   # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell       # autocorrects cd misspellings
shopt -s checkwinsize  # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist       # save multi-line commands in history as single line
shopt -s dirspell      # correct spelling errors during tab-completion
shopt -s extglob       # enable extended pattern-matching features
shopt -s histappend    # don't overwrite history
shopt -s nocaseglob    # pathname expansion will be treated as case-insensitive
shopt -s globstar      # the pattern "**" used in a pathname expansion context

bind 'set completion-ignore-case on'     # ignore case when doing completion
bind 'set mark-symlinked-directories on' # append a slash when autocompleting symbolic links to directories
bind 'set show-all-if-ambiguous on'      # immediately show all possible completions
bind 'set blink-matching-paren on'       # when inserting a bracket, briefly jump to its match
bind 'set visible-stats on'              # show extra file information when completing, like 'ls -F' does
bind 'set skip-completed-text on'        # be more intelligent when autocompleting by also looking at the text after the cursor

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# bind Meta-p/Meta-n keys to search history based on current cmdline
bind -m emacs-meta '"p":history-search-backward'
bind -m emacs-meta '"n":history-search-forward'

# make tab cycle through commands instead of listing
bind -m emacs '"\t":menu-complete'
bind -m emacs '"\e[Z":menu-complete-backward'

# disable ^S and ^Q mapping
stty start undef
stty stop undef

# History options
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE='&:l:l[alrs]:[bf]g:jobs:exit:pwd:cd:clear:history'
HISTSIZE=10000
HISTFILESIZE=20000

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# save and reload the history after each command finishes
PROMPT_COMMAND="history -a; history -r;$PROMPT_COMMAND"

# alert after command execution ends
PROMPT_COMMAND="printf \"\\a\";$PROMPT_COMMAND"

# Zsh-like trick for highlighting missing linefeeds
PROMPT_COMMAND="printf \"%%%\$((COLUMNS-1))s\\r\";$PROMPT_COMMAND"

# show subshell level in the promt
for (( i = 0; i < SHLVL; i++ )); do
	__shlvl="$__shlvl>"
done

# visualizing exit codes
last_exit_code() {
	local exit_code=$?
	case "$exit_code" in
	0|130) ;;
	*)
		printf '\e[2;37mLast command ended with exit code: \e[31m%s\e[0m\n' $exit_code
	esac
}

PROMPT_COMMAND="last_exit_code;$PROMPT_COMMAND"

# set prompt
PS1='\u@\h:\w\$ ${__shlvl} '
PS2='> '
PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

if command -v tput >/dev/null && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)

	# Less Colors for Man Pages
	export LESS='-iSRX --tabs=4'
	export LESS_TERMCAP_mb=$'\e[01;35m'
	export LESS_TERMCAP_md=$'\e[33m'
	export LESS_TERMCAP_me=$'\e[0m'
	export LESS_TERMCAP_us=$'\e[35m'
	export LESS_TERMCAP_ue=$'\e[0m'
	export LESS_TERMCAP_so=$'\e[47;30m'
	export LESS_TERMCAP_se=$'\e[0m'

	# customize colors for grep
	export GREP_COLORS='mt=01;31:sl=:cx=:fn=34:ln=32:bn=32:se=2;37'

	# set color prompt
	PS1='\[\e[1;32m\]\u@\[\e[1;36m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ ${__shlvl} '
	trap "echo -ne '\e[0m'" DEBUG
fi

if command -v dircolors > /dev/null; then
	if [ -f "$HOME/.dircolors" ]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# enable programmable completion features if it is not already
# enabled in /etc/bash.bashrc and /etc/profile
if [ -z "$BASH_COMPLETION_VERSINFO" ] && ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Functions definitions.
[ -f ~/.bash_functions ] && . ~/.bash_functions

# load fzf shell extension
for _conf in \
	"${XDG_DATA_HOME:-$HOME/.local}/share/fzf/shell/key-bindings.bash" \
	/usr/share/fzf/shell/key-bindings.bash
do
[ -f "$_conf" ] &&
	. "$_conf"
done
unset _conf

# vim:ft=sh:ts=4:sw=4
