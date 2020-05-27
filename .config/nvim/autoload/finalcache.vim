" finalcache.vim - a single place for auxiliary files
" Author: SmartFinn
" Homepage: http://github.com/SmartFinn/finalcache
" Version: 0.0.0
" TODO: global variable g:vimcache_dir

function! finalcache#init(...) abort
  let source_path = a:0 ? expand(a:1, 1) : expand('$HOME/.cache/vim', 1)

  " Create cache directory if it does not exist
  if !isdirectory(source_path)
    call mkdir(source_path, 'p')
  endif

  " Set global variable
  let g:cache_dir = source_path . '/'

  let dir_list = {
        \ 'backupdir': 'backup',
        \ 'directory': 'swap',
        \ 'undodir': 'undo'}

  for [optionname, dirname] in items(dir_list)
    let directory = source_path . '/' . dirname
    exec 'set ' . optionname . '=' . directory
    if !isdirectory(directory)
      call mkdir(directory, 'p')
    endif
  endfor

  " Addition options
  if has('nvim')
    exec 'set shada+=n' . g:cache_dir . 'shada'
  else
    exec 'set viminfo+=n' . g:cache_dir . 'viminfo'
  endif

endfunction
