" SASS specific settings.
" Options
setlocal tabstop=2
setlocal shiftwidth=2
setlocal shiftround
setlocal expandtab
setlocal foldmethod=indent
setlocal nowrap

" Compiler
setlocal makeprg=sass\ \"%:p\"\ \"%:p:r.css\"
setlocal errorformat=%ESyntax\ %trror:%m,%C\ \ \ \ \ \ \ \ on\ line\ %l\ of\ %f,%Z%m

" Syntax

" Macros

" Mapping
map <silent> <buffer> <F9> :update \| silent! make \| redraw! \| cwindow<CR>

" Plugins
if exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns.sass = '^\s\+\w\+\|\w\+[):;]\?\s\+\|[@!]'
endif

" vim:ft=vim
