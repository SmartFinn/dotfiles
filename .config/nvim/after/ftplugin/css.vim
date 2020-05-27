" CSS3 specific settings.
" Options
setlocal tabstop=2
setlocal shiftwidth=2
setlocal shiftround
setlocal expandtab
setlocal foldmethod=indent
setlocal nowrap

" Compiler

" Syntax
syntax match cssComment "//.*$" contains=@Spell

" Macros
" Alphabetically sort CSS properties in file with :SortCSS
command! -buffer SortCSS :g#\({\n\)\@<=#.,/}/sort

" Mapping
map <silent> <buffer> <F9> :update<CR>

" Plugins

" vim:ft=vim
