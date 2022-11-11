# when using sudo, use alias expansion (otherwise sudo ignores your aliases)
alias sudo='sudo'

# default to human readable figures
alias df='df --si --print-type'
alias du='du --si'
alias ls='ls --si --classify --group-directories-first --color=auto'
alias free='free --human'

# enable color support
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ip='ip --color=auto'
alias diff='diff --color=auto'

# change the behavior of some commands
alias ping='ping -c 4'
alias ping6='ping6 -c 4'
alias mkdir='mkdir -p'
alias chmod='chmod -c'
alias chown='chown -c'
alias rm='rm -v -I'
alias mv='mv -v'
alias cp='cp -v'
alias pgrep='pgrep -lf'
alias dirs='dirs -v'
alias dd='dd status=progress'
alias dmesg='dmesg -H'

# misc. useful aliases
alias ll='ls -l'
alias la='ls -A'
alias lr='ls -R'
alias lt='ls -ltra'
alias ip6='ip -6'
alias pause='echo -n "Press enter to continue"; read'
alias dush='du -sh * | sort -hr | head'
alias wipe='shred -vzun 0'
alias mkown='sudo chown $USER: -cR'
alias nocomment="grep -Ev '^\s*(#|$)'"
alias nocow='chattr +C'
alias reflink='cp -ax --reflink=always'

if command -v screen >/dev/null; then
	alias screen="screen -x -R"
fi

# vim:ft=sh:ts=4:sw=4
