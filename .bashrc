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

# History options
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE='&:l:l[alrs]:[bf]g:jobs:exit:pwd:cd:clear:history'
HISTSIZE=10000
HISTFILESIZE=10000

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# save and reload the history after each command finishes
PROMPT_COMMAND='history -a; history -r'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

if command -v tput > /dev/null && [ "$(tput -T "$TERM" colors)" -ge 8 ]; then
	# Less Colors for Man Pages
	export LESS_TERMCAP_mb=$'\e[01;35m'
	export LESS_TERMCAP_md=$'\e[33m'
	export LESS_TERMCAP_me=$'\e[0m'
	export LESS_TERMCAP_us=$'\e[35m'
	export LESS_TERMCAP_ue=$'\e[0m'
	export LESS_TERMCAP_so=$'\e[47;30m'
	export LESS_TERMCAP_se=$'\e[0m'

	# enable color support of ls and also add handy aliases
	alias ls='ls --color=auto'
	# alias dir='dir --color=auto'
	# alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'

	# set prompt
	PS1='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ '
	PS2='> '
	PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

if command -v dircolors > /dev/null; then
	if [ -f "$HOME/.dircolors" ]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# include external files if they exist
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
fi

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

[ -f "$HOME/.bash_aliases"   ] && . "$HOME/.bash_aliases"
[ -f "$HOME/.bash_functions" ] && . "$HOME/.bash_functions"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell.d/init.sh" ] &&
	. "${XDG_CONFIG_HOME:-$HOME/.config}/shell.d/init.sh"
[ -f "${XDG_DATA_HOME:-$HOME/.local}/share/fzf/shell/key-bindings.bash" ] &&
	. "${XDG_DATA_HOME:-$HOME/.local}/share/fzf/shell/key-bindings.bash"
