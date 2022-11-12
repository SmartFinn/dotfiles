" VIM setting file (required version 8.1 and higher)
" vim:ft=vim:sw=2:fen:fdm=marker:fmr={{{,}}}

" Init {{{1
" ====

" XDG support
" https://blog.joren.ga/vim-xdg"

if empty($MYVIMRC) | let $MYVIMRC = expand('<sfile>:p') | endif

if empty($XDG_CACHE_HOME)  | let $XDG_CACHE_HOME  = $HOME."/.cache"       | endif
if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME."/.config"      | endif
if empty($XDG_DATA_HOME)   | let $XDG_DATA_HOME   = $HOME."/.local/share" | endif
if empty($XDG_STATE_HOME)  | let $XDG_STATE_HOME  = $HOME."/.local/state" | endif

set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath+=$XDG_DATA_HOME/vim
set runtimepath+=$XDG_CONFIG_HOME/vim/after

set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

let g:netrw_home = $XDG_DATA_HOME."/vim"
call mkdir($XDG_DATA_HOME."/vim/spell", 'p', 0700)

set backupdir=$XDG_CACHE_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
set directory=$XDG_CACHE_HOME/vim/swap   | call mkdir(&directory, 'p', 0700)
set undodir=$XDG_CACHE_HOME/vim/undo     | call mkdir(&undodir,   'p', 0700)
set viewdir=$XDG_CACHE_HOME/vim/view     | call mkdir(&viewdir,   'p', 0700)


" Options {{{1
" =======

" Includes snippets from sensible.vim by Tim Pope <http://tpo.pe/>

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if v:version > 703 || v:version == 703 && has("patch541")
  " Delete comment character when joining commented lines
  set formatoptions+=j
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif

set noswapfile
set undofile

set lazyredraw

set hidden
set autoread
set modeline

set nofoldenable
set foldmethod=marker

set scrolloff=5
set sidescroll=1
set sidescrolloff=15

set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set virtualedit=block

set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent

set hlsearch
set incsearch
set ignorecase
set smartcase
set magic

" Don't try to highlight lines longer than 250 characters.
set synmaxcol=250

set showmatch
set matchtime=2
set matchpairs+=<:>

set nojoinspaces

set display+=lastline
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,nbsp:.

set statusline=%(%m\ %)%<%F\ (  " modified flag and full path
set statusline+=%(%{strlen(&ft)?&ft:'none'},\ %) " file type
set statusline+=%(%{strlen(&fenc)?&fenc:'none'},\ %) " file encoding
set statusline+=%(%{&ff}%))     " file format
set statusline+=%=              " separator
set statusline+=%-8.(%k%)       " current keymap
set statusline+=%-8.(B:%n%)     " buffer
set statusline+=%-8.(C:%v%)     " column
set statusline+=%-12.(L:%l/%L%) " line
set statusline+=%P              " percents

set laststatus=2

set ruler
set showcmd

set history=512
set wildmenu
set wildignore=.svn,.git,.bzr,.hg
set wildignore+=*~,*.swp,*.swo
set wildignore+=*.luac,*.pyc,*.rbc,*.class,classes
set wildignore+=*.o,*.mo,*.so,*.obj
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.avi,*.mkv,*.mpg,*.mpeg,*.vob
set wildignore+=*.mp3,*.ogg,*.aac,*.flac
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.exe,*.dll,*.manifest
set wildignore+=.sass-cache
set wildignore+=.DS_Store,Thumbs.db
set confirm

set splitright
set splitbelow

" Don't save options to session file - it's possibly buggy
set sessionoptions-=options
set viewoptions-=options

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 500 files
"           | |    +--Remember up to 10000 lines in each register
"           | |    |      +--Remember up to 1MB in each register
"           | |    |      |     +--Remember last 1000 search patterns
"           | |    |      |     |     +---Remember last 1000 commands
"           | |    |      |     |     |
"           v v    v      v     v     v
set viminfo=h,'500,<10000,s1000,/1000,:1000,n$XDG_CACHE_HOME/vim/viminfo

" Search down into subfolders
set path+=**

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

if &term =~ '256color' || &term =~ 'kitty' || &term =~ 'alacritty'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

colorscheme desert


" Functions and commands {{{1
" ======================

" Don't close window, when deleting a buffer
command! Bclose call BufcloseCloseIt()
function! BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif
  if bufnr("%") == l:currentBufNum
    new
  endif
  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

" If you need to save file with root permission, just type :SudoWrite to save
command! -bar SudoWrite :
  \ setlocal nomodified |
  \ silent exe 'write !sudo tee "%:p" >/dev/null' |
  \ let &modified = v:shell_error
cabbrev sw SudoWrite
cabbrev ws SudoWrite

" Aliases
cabbrev ft setfiletype
cabbrev <expr> %% expand('%:p:h')

" Type :enc= for set encoding
cabbrev <expr> enc expand('e! ++enc')

" Type :ff= for set fileformats
cabbrev <expr> ff expand('e! ++ff')

" Command corrections
cabbrev W w
cabbrev Q q


" Autocommands {{{1
" ============

augroup vimrc
  au!

  " Auto-update this config file
  au BufWritePost $MYVIMRC source $MYVIMRC

  " Restore cursor to file position in previous editing session
  au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$")
        \ |   exec "normal! g'\""
        \ | endif

  " Automatically creates parent directories for the current file if they
  " don't exist yet (auto_mkdir based)
  au BufWritePre,FileWritePre *
        \ let b:dir = expand('<afile>:p:h')
        \ | if !isdirectory(b:dir) && !(b:dir =~ '://')
        \ |   call mkdir(iconv(b:dir, &encoding, &termencoding), 'p')
        \ | endif

  " Auto change directory
  au BufEnter * silent! lcd %:p:h:gs/ /\ /

  " Better undo in Insert mode
  au CursorHoldI * :call feedkeys("\<C-G>u",'t')
  au InsertEnter * let s:keep_ut = &ut | let &ut = 1000
  au InsertLeave * let &ut = s:keep_ut
augroup END

" Close quickfix window by q key press
augroup quickfix
  au!
  au FileType qf setlocal nowrap nolist nocursorcolumn
  au FileType qf noremap <buffer> q :close<CR>
augroup END

augroup help
  au!
  au FileType help nnoremap <buffer> <silent> q :bdelete<CR>
augroup END

augroup netrw
  au!
  au FileType netrw nnoremap <buffer> <silent> ? :help netrw-quickmap<CR>
  au FileType netrw nnoremap <buffer> <silent> <C-R> <Plug>NetrwRefresh
  au FileType netrw nnoremap <buffer> <silent> gq :bdelete<CR>
  au FileType netrw nmap <buffer> <silent> o <CR>
  au FileType netrw nmap <buffer> <silent> <C-L> <Nop>
augroup END

" Remove trailing whitespaces on save
au BufWritePre * %s/\s\+$//e


" Mapping {{{1
" =======

" Leader keys
" -----------

" Search & replace the word under the cursor
nmap <Leader>S :%s/<C-R>=expand("<cword>")<CR>/<C-R>=expand("<cword>")<CR>
vmap <Leader>S y:%s/<C-R>"/<C-R>"

" Open vimrc
nmap <silent> <Leader>, :tabedit $MYVIMRC<CR>

" Delete current buffer
nmap <silent> <Leader>q :bdelete<CR>


" New key mapping
" ---------------

" Open parent directory
nmap <silent> - :e %:p:h<CR>

" Create tab
map <silent> <C-W>N :tabnew<CR>

" TAB = Ctrl-W
map <Tab> <C-W>
map <S-Tab> <C-W>
noremap <Tab><Tab> <C-W>w
noremap <Tab><S-Tab> <C-W>W
noremap <S-Tab><S-Tab> <C-W>W

" Multiple cursors for poor man
" Tip: use . (dot) to apply the changes, n/N - to skip
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
vmap gb *cgn
vmap gB *cgN

" Improve work with brackets
onoremap ( i(
onoremap ) a(
onoremap [ i[
onoremap ] a[
onoremap { i{
onoremap } a{
onoremap < i<
onoremap > a<

" Next/prev buffer
map ]b :bnext<CR>
map [B :bprevious<CR>

" Option toggling
nmap Zc :set cursorline!<CR>
nmap Zh :set hlsearch!<CR>
nmap Zi :set ignorecase!<CR>
nmap Zl :set list!<CR>
nmap Zn :set number!<CR>
nmap Zp :set paste!<CR>
nmap Zr :set relativenumber!<CR>
nmap Zs :set spell!<CR>
nmap Zu :set cursorcolumn!<CR>
nmap Zw :set wrap!<CR>

" Change defaults
" ---------------
" Vertical and horizontal split then hop to a new buffer
map <silent> <C-W>s :new<CR>
map <silent> <C-W>v :vnew<CR>

" make Y consistent with C and D. See :help Y
nnoremap Y y$

" Don't clobber the unnamed register when pasting over text in visual mode
vnoremap p pgvy

" Go to last non-blank character (strip trailing white space)
vnoremap $ g_

" Don't jump to the next search result, just highlight
nnoremap * *N
nnoremap # #N
nnoremap g* g*N
nnoremap g# g#N

" Highlight the selected text
vnoremap <silent> * y/\C<C-R>"<CR>N
vnoremap <silent> # y?\C<C-R>"<CR>N

" Center display after jumping
nnoremap n nzz
nnoremap N Nzz
nnoremap g; g;zz
nnoremap g, g,zz

" Quick macro to the q registry, use Q to play back
nnoremap Q @q

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" reselect last paste
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Make <Backspace> act as <Delete> in Visual mode?
vnoremap <BS> x

" Fix PageDown/PageUp
noremap <PageUp> <C-U>
noremap <PageDown> <C-D>

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Use <C-L> to clear the highlighting of :set hlsearch.
if &hlsearch
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Use space to jump down a page (like browsers do)...
nnoremap <Space> <PageDown>
vnoremap <Space> <PageDown>

" Remap Ctrl+C on Esc (needed for the correct exit from insert mode)
imap <C-C> <Esc>


" Others {{{1
" ======

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" let g:loaded_netrwPlugin=1  " uncomment to disable netrw plugin
let g:netrw_home = '/tmp'
let g:netrw_banner = 0        " disable annoying banner
let g:netrw_browse_split = 4  " open in prior window
let g:netrw_altv = 1          " open splits to the right
let g:netrw_winsize = 24
let g:netrw_liststyle = 3     " tree view
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide .= ',\(^\|\s\s\)\zs\.\S\+'
