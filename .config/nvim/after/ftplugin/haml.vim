" HAML specific settings.
" Options
setlocal tabstop=2
setlocal shiftwidth=2
setlocal shiftround
setlocal expandtab
setlocal foldmethod=indent
setlocal nowrap

" Compiler
setlocal makeprg=haml\ \"%:p\"\ \"%:p:r.html\"
setlocal errorformat=%ESyntax\ %trror:%m,%C\ \ \ \ \ \ \ \ on\ line\ %l\ of\ %f,%Z%m

" Syntax
syntax match htmlComment "/.*$" contains=@Spell

" Macros

" Mapping
map <silent> <buffer> <F9> :update \| silent! make \| redraw! \| cwindow<CR>

" Plugins

" vim:ft=vim
