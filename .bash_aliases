# default to human readable figures
alias df='df -h --print-type'
alias du='du -h'
alias ls='ls -h --classify --group-directories-first --color=auto'
alias free='free -h'

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

if command -v screen >/dev/null; then
	alias screen="screen -x -R"
fi

# vim:ft=sh:ts=4:sw=4
