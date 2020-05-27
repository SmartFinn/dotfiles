" Python specific settings
" Options
setlocal tabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal expandtab
setlocal foldmethod=indent
setlocal textwidth=79
setlocal nowrap

" Compiler
setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Syntax
" Display tabs at the beginning of a line in Python mode as bad.
syntax match pythonError /^\t\+/
" Make trailing whitespace be flagged as bad.
syntax match pythonError /\s\+$/

" Macros
" Remove all trailing whitespace
command! -buffer RemoveTrailingWhitespace :%s/\s\+$//e

" Mapping
map <silent> <buffer> <F8> :!/usr/bin/env python "%:p"<CR>
map <silent> <buffer> <F9> :update \| silent! make \| redraw! \| cwindow<CR>

" Plugins
let python_highlight_all=1

" vim:ft=vim
