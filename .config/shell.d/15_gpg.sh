command -v gpg >/dev/null || return 0

GPG_TTY="$(tty)"
export GPG_TTY
