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
map <silent> <buffer> <F8> :!/bin/bash "%"<CR>
map <silent> <buffer> <F9> :update<CR>

" Plugins

" vim:ft=vim
