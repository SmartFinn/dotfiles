" XML specific settings.
" Options
setlocal tabstop=4
setlocal shiftwidth=4
setlocal noshiftround
setlocal noexpandtab
setlocal foldmethod=indent
setlocal matchpairs+=<:>
setlocal nowrap

" Compiler

" Syntax

" Macros
" Delete HTML tags but keeps text
command! -buffer DeleteAllTags :%s#<[^>]+>##g

" Mapping
map <silent> <buffer> <F9> :update<CR>

" Plugins

" vim:ft=vim
