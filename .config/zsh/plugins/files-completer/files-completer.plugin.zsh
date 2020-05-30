# Ctrl+X / and Ctrl+X Ctrl+F - completes all files during a special completion
zle -C files_completer complete-word _generic
zstyle ':completion:files_completer::::' completer _files
bindkey '^X/' files_completer
bindkey '^X^F' files_completer
