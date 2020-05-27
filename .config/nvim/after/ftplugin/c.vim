" C specific settings
" Options
setlocal tabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal foldmethod=indent
setlocal textwidth=79
setlocal nowrap

" Compiler
setlocal makeprg=gcc\ %\ -o\ %:r

" Syntax

" Macros
" Remove all trailing whitespace
command! -buffer RemoveTrailingWhitespace :%s/\s\+$//e

" Mapping
map <silent> <buffer> <F8> :!"%:p:r"<CR>
map <silent> <buffer> <F9> :update \| silent! make \| redraw! \| cwindow<CR>

" Plugins

" vim:ft=vim
