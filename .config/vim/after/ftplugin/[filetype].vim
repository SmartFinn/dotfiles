" [filetype] specific settings.
" Options
setlocal tabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal expandtab
setlocal foldmethod=indent
setlocal nowrap

" Compiler

" Syntax

" Macros

" Mapping
map <silent> <buffer> <F8> :!/usr/bin/env interpreter "%:p"<CR>
map <silent> <buffer> <F9> :update \| silent! make \| redraw! \| cwindow<CR>

" Plugins

" vim:ft=vim
