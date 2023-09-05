" Shell specific settings.
" Options
setlocal tabstop=4
setlocal shiftwidth=4
setlocal noshiftround
setlocal noexpandtab
setlocal foldmethod=indent
setlocal textwidth=96
setlocal nowrap

" Compiler

" Syntax

" Macros

" Mapping
map <silent> <buffer> <F8> :!/usr/bin/zsh "%:p"<CR>
map <silent> <buffer> <F9> :update<CR>

" Run the current line with shell
" https://parobalth.github.io/vim-run-line
nmap <Leader><Enter> :.w !zsh<CR>
vmap <Leader><Enter> :'<'>.w !zsh<CR>

" Plugins

" vim:ft=vim
