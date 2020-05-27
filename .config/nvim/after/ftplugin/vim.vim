" Vim specific settings.
" Options
setlocal tabstop=2
setlocal shiftwidth=2
setlocal shiftround
setlocal expandtab
setlocal foldmethod=marker
setlocal nowrap

" Compiler

" Mapping
map <silent> <buffer> <F8> :silent source %:p<CR>
map <silent> <buffer> <F9> :update<CR>

" Syntax

" Macros

" Plugins

" vim:ft=vim
