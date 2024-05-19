# based on http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

# Create directory under cursor or the selected area
function inplaceMkDirs () {
	# Press Ctrl-x Shift-m to create the directory under the cursor or the
	# selected area.
	# To select an area press ctrl-@ or ctrl-space and use the cursor.
	# Use case: you type "mv abc ~/testa/testb/testc/" and remember that the
	# directory does not exist yet -> press ctrl-XM and problem solved
	local PATHTOMKDIR
	if ((REGION_ACTIVE==1)); then
		local F=$MARK T=$CURSOR
		if [[ $F -gt $T ]]; then
			F=${CURSOR}
			T=${MARK}
		fi
		# get marked area from buffer and eliminate whitespace
		PATHTOMKDIR=${BUFFER[F+1,T]%%[[:space:]]##}
		PATHTOMKDIR=${PATHTOMKDIR##[[:space:]]##}
	else
		local bufwords iword
		bufwords=(${(z)LBUFFER})
		iword=${#bufwords}
		bufwords=(${(z)BUFFER})
		PATHTOMKDIR="${(Q)bufwords[iword]}"
	fi
	[[ -z "${PATHTOMKDIR}" ]] && return 1
	PATHTOMKDIR=${~PATHTOMKDIR}
	if [[ -e "${PATHTOMKDIR}" ]]; then
		zle -M " path already exists, doing nothing"
	else
		zle -M "$(mkdir -p -v "${PATHTOMKDIR}")"
		zle end-of-line
	fi
}

zle -N inplaceMkDirs
bindkey '^xM' inplaceMkDirs

# only slash should be considered as a word separator:
function slash-backward-kill-word () {
	local WORDCHARS="${WORDCHARS:s@/@}"
	zle backward-kill-word
}

zle -N slash-backward-kill-word
bindkey '\e^?' slash-backward-kill-word

# press "ctrl-e d" to insert the actual date in the form yyyy-mm-dd
function insert-datestamp () { LBUFFER+=${(%):-'%D{%Y-%m-%d}'}; }
zle -N insert-datestamp
bindkey '^Ed' insert-datestamp

# press esc-m for inserting last typed word again (thanks to caphuso!)
function insert-last-typed-word () { zle insert-last-word -- 0 -1 };
zle -N insert-last-typed-word
bindkey '\em' insert-last-typed-word

# add a command line to the shells history without executing it
function commit-to-history () {
	print -s ${(z)BUFFER}
	zle send-break
}

zle -N commit-to-history
bindkey '^X^H' commit-to-history  # Ctrl-X Ctrl-Backspace

# run command line as user root via sudo:
function sudo-command-line () {
	[[ -z $BUFFER ]] && zle up-history
	if [[ $BUFFER != sudo\ * ]]; then
		BUFFER="sudo $BUFFER"
		CURSOR=$(( CURSOR+5 ))
	fi
}

zle -N sudo-command-line
bindkey '^Es' sudo-command-line

### jump behind the first word on the cmdline.
### useful to add options.
function jump_after_first_word () {
	local words
	words=(${(z)BUFFER})

	if (( ${#words} <= 1 )) ; then
		CURSOR=${#BUFFER}
	else
		CURSOR=${#${words[1]}}
	fi
}

zle -N jump_after_first_word
bindkey '^Ea' jump_after_first_word

autoload -Uz insert-files
zle -N insert-files
bindkey '^Xf' insert-files

#f5# List files which have been accessed within the last {\it n} days, {\it n} defaults to 1
function accessed () {
	emulate -L zsh
	print -l -- *(a-${1:-1})
}

#f5# List files which have been changed within the last {\it n} days, {\it n} defaults to 1
function changed () {
	emulate -L zsh
	print -l -- *(c-${1:-1})
}

#f5# List files which have been modified within the last {\it n} days, {\it n} defaults to 1
function modified () {
	emulate -L zsh
	print -l -- *(m-${1:-1})
}

#f1# Provides useful information on globbing
function help-zshglob () {
	cat <<- EOF
	/      directories
	.      plain files
	@      symbolic links
	=      sockets
	p      named pipes (FIFOs)
	*      executable plain files (0100)
	%      device files (character or block special)
	%b     block special files
	%c     character special files
	r      owner-readable files (0400)
	w      owner-writable files (0200)
	x      owner-executable files (0100)
	A      group-readable files (0040)
	I      group-writable files (0020)
	E      group-executable files (0010)
	R      world-readable files (0004)
	W      world-writable files (0002)
	X      world-executable files (0001)
	s      setuid files (04000)
	S      setgid files (02000)
	t      files with the sticky bit (01000)

	print *(m-1)          # Files modified up to a day ago
	print *(a1)           # Files accessed a day ago
	print *(@)            # Just symlinks
	print *(Lk+50)        # Files bigger than 50 kilobytes
	print *(Lk-50)        # Files smaller than 50 kilobytes
	print **/*.c          # All *.c files recursively starting in \$PWD
	print **/*.c~file.c   # Same as above, but excluding 'file.c'
	print (foo|bar).*     # Files starting with 'foo' or 'bar'
	print *~*.*           # All Files that do not contain a dot
	chmod 644 *(.^x)      # make all plain non-executable files publically readable
	print -l *(.c|.h)     # Lists *.c and *.h
	print **/*(g:users:)  # Recursively match all files that are owned by group 'users'
	echo /proc/*/cwd(:h:t:s/self//) # Analogous to "ps ax | awk '{print \$1}'"
	EOF
}
