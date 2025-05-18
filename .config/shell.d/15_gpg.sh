command -v gpg >/dev/null || return 0

# Set the GPG_TTY to be the same as the TTY, either via the env var
# or via the tty command.
if [ -n "$TTY" ]; then
	GPG_TTY=$(tty)
else
	GPG_TTY="$TTY"
fi

export GPG_TTY
