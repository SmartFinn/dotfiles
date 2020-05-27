" gitcommit specific settings.
" Options
setlocal tabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal expandtab
setlocal foldmethod=indent
setlocal wrap
setlocal spell

" Compiler

" Syntax

" Macros
au BufRead,BufNewFile COMMIT_EDITMSG normal! gg
au BufRead,BufNewFile COMMIT_EDITMSG startinsert

" Mapping
map <silent> <buffer> <F9> :update<CR>

" Plugins

" vim:ft=vim
