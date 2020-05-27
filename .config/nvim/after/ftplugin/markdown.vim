" Markdown specific settings.
" Options
setlocal tabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal expandtab
setlocal foldmethod=manual
setlocal wrap

" Compiler
setlocal makeprg=markdown\ \"%:p\"\ &>\ \"%:p:r.html\"

" Syntax

" Macros

" Mapping
map <silent> <buffer> <F9> :update \| silent! make \| redraw! \| cwindow<CR>

" Plugins

" vim:ft=vim
