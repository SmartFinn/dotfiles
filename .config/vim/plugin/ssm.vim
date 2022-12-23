" Simple session manager

command! -nargs=? SS call SessionSave('<args>')
function! SessionSave(name)
  let s:name = a:name != '' ? a:name : 'quick_save'
  exec 'mksession! ' . g:cache_dir.s:name . '.session'
  echo "Session" s:name "saved."
endfunction

command! -nargs=? SR call SessionRestore('<args>')
function! SessionRestore(name)
  let s:name = a:name != '' ? a:name : 'quick_save'
  let s:path = g:cache_dir . s:name . '.session'
  if file_readable(s:path)
    exec 'source ' . s:path
    exec 'silent! source ~/.vimrc'
    echo "Session" s:name "restored."
  else
    echo "Session" s:name "not found."
  endif
endfunction

" Save last state when exit
au VimLeavePre * call SessionSave('last_state')
