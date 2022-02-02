command -v fzf >/dev/null || return 0
command -v fd >/dev/null || return 0

# fzf's command
export FZF_DEFAULT_COMMAND="fd"
# CTRL-T's command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# ALT-C's command
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
