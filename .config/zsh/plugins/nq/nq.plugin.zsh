# file: nq.plugin.zsh
# unix command line queue utility
# https://github.com/chneukirchen/nq

(( $+commands[nq] )) || return 0

fpath=( $0:A:h $fpath )

export NQDIR=/tmp/nq

[ -d "$NQDIR" ] || mkdir -p "$NQDIR"

nq-clear() {
	find "$NQDIR" -maxdepth 1 -type f -name ',*' -delete
}
