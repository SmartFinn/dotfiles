" Coffee specific settings.
" Options
setlocal tabstop=2
setlocal shiftwidth=2
setlocal shiftround
setlocal expandtab
setlocal foldmethod=indent
setlocal nowrap

" Compiler
setlocal makeprg=coffee\ -c\ \"%:p\"
setlocal errorformat=%EError:\ In\ %f\,\ Parse\ error\ on\ line\ %l:\ %m,\
	\ %EError:\ In\ %f\,\ %m\ on\ line\ %l,%W%f(%l):\ lint\ warning:\ %m,\
	\ %-Z%p^,%W%f(%l):\ warning:\ %m,%-Z%p^,%E%f(%l):\ SyntaxError:\ %m,\
	\ %-Z%p^,%-G

" Mapping
map <silent> <buffer> <F9> :update \| silent! make \| redraw! \| cwindow<CR>

" Syntax

" Macros

" Plugins

" vim:ft=vim
