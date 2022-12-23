" VIM setting file (required version 8.1 and higher)
" vim:ft=vim:fen:fdm=marker:fmr={{{,}}}

" Initialization {{{1
" ==============

set nocompatible

" Don't read vimrc if run with sudo
if exists('$SUDO_USER')
  if !isdirectory('/tmp/vim')
    call mkdir('/tmp/vim', 'p')
  endif
  set runtimepath=/tmp/vim,$VIMRUNTIME
  set viminfo+=n/tmp/vim/viminfo
  set noswapfile
  finish
endif

syntax off
filetype off

" Load vimcache
if (has("nvim"))
  call vimcache#init($HOME . '/.cache/nvim')
else
  call vimcache#init($HOME . '/.cache/vim')
endif

" Plugins {{{1
" =======

call plug#begin('~/.config/vim/bundle')

" netrw
" Uncomment the line below to disable netrw plugin
" let g:loaded_netrwPlug = 1
let g:netrw_home = g:vimcache_dir
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
" let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Surround
Plug 'tpope/vim-surround'

" ViewDoc — flexible viewer for any documentation
Plug 'powerman/vim-plugin-viewdoc'
let g:viewdoc_openempty = 0
cabbrev h   ViewDocHelp
cabbrev he  ViewDocHelp
cabbrev hel ViewDocHelp

" Dark powered asynchronous completion framework for neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
endif

" UltiSnips — TextMate-like snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsNoPythonWarning = 1
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Airline — lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#trailing_format = '[%s]trailing'
let g:airline#extensions#whitespace#mixed_indent_format = '[%s]mixed-indent'
let g:airline#extensions#whitespace#long_format = '[%s]long'
let g:airline#extensions#whitespace#mixed_indent_file_format = '[%s]mix-indent-file'
let g:airline_theme = 'onedark'

" Fugitive — git wrapper
Plug 'tpope/vim-fugitive'

" Git runtime files
Plug 'tpope/vim-git'

" Repeat — enable repeating supported for plugins
Plug 'tpope/vim-repeat'

" Unimpaired — pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'
nmap Z yo

" Startify — start screen, sessions and bookmarks manager
Plug 'mhinz/vim-startify'
let g:startify_bookmarks = [ '~/.config/nvim/init.vim' ]
let g:startify_session_dir = g:vimcache_dir . 'session'
let g:startify_custom_header = []

" Tcomment — An extensible & universal comment vim-plugin that also handles
" embedded filetypes
" Ctrl-/ (Ctrl-_) by default
Plug 'tomtom/tcomment_vim'
" let g:tcomment_mapleader1 = '<C-\>'
let g:tcomment_maps = 0  " disable default mapping
nmap <C-_> <Plug>TComment_<c-_><c-_>
xmap <C-_> <Plug>TComment_<c-_><c-_>
imap <C-_> <Plug>TComment_<c-_><c-_>
" mapping for kitty terminal:
nmap <C-/> <Plug>TComment_<c-_><c-_>
xmap <C-/> <Plug>TComment_<c-_><c-_>
imap <C-/> <Plug>TComment_<c-_><c-_>

" Readline style insertion
Plug 'tpope/vim-rsi'

" helpers for UNIX
Plug 'tpope/vim-eunuch'

" Syntax checking hacks for vim
Plug 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
" Jump to the first issue detected, but only if it's an error
let g:syntastic_auto_jump = 2
" Don't open window on errors, but close window if no errors
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5
let g:loaded_syntastic_ansible_ansible_lint_checker = 1
let g:syntastic_python_checkers = ['pyflakes', 'flake8', 'python3']
let g:syntastic_python_flake8_args = '--ignore=D100,D101,D102,D103 --max-line-length=100'
let g:syntastic_python_pylint_args = '--disable=invalid-name,missing-docstring,too-many-instance-attributes,logging-fstring-interpolation'

" Vim plugin for easily moving text selections around
Plug 'zirrostig/vim-schlepp'
vmap <Up>    <Plug>SchleppUp
vmap <Down>  <Plug>SchleppDown
vmap <Left>  <Plug>SchleppLeft
vmap <Right> <Plug>SchleppRight

" Text filtering and alignment
Plug 'godlygeek/tabular'

" Vim plugin for copying to the system clipboard with text-objects and motions
Plug 'christoomey/vim-system-copy'

" Syntax highlights
Plug 'zainin/vim-mikrotik', { 'for': 'rsc' }
Plug 'vim-scripts/iptables', { 'for': 'iptables' }

" A collection of language packs for Vim
Plug 'sheerun/vim-polyglot'

" Make terminal vim and tmux work better together
Plug 'tmux-plugins/vim-tmux-focus-events', !empty($TMUX) ? {} : { 'on': [] }

" seamless integration for vim and tmux's clipboard
" requires: 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard', !empty($TMUX) ? {} : { 'on': [] }

" Directory viewer for Vim
Plug 'justinmk/vim-dirvish'
" group-directories-first sorting
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'
" override the netrw :Explore, :Sexplore, :Vexplore commands
let g:loaded_netrwPlug = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" Handles bracketed-paste-mode in vim (aka. automatic `:set paste`)
Plug 'ConradIrwin/vim-bracketed-paste'

" Vim plugin for shfmt
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' }

" A dark Vim/Neovim color scheme inspired by Atom's One Dark syntax theme
Plug 'joshdick/onedark.vim'
let g:onedark_hide_endofbuffer = 1
let g:onedark_color_overrides = {
\ "black": {"gui": "#20242c", "cterm": "235", "cterm16": "0" },
\}

" shows a git diff in the gutter (sign column) and stages/undoes hunks
Plug 'airblade/vim-gitgutter'
" let g:gitgutter_terminal_reports_focus = 0
" let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = '▊ '
let g:gitgutter_sign_modified = '▊ '
let g:gitgutter_sign_removed = '▂▂'
let g:gitgutter_sign_removed_first_line = '▔▔'
let g:gitgutter_sign_modified_removed = '▊ '
" update the signs when you save a file
autocmd BufWritePost * GitGutter

" Show a diff using Vim its sign column
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = [ 'hg', 'rcs' ]
let g:signify_sign_add               = '▊'
let g:signify_sign_delete            = '▂'
let g:signify_sign_delete_first_line = '▔'
let g:signify_sign_change            = '▊'

" Auto close parentheses and repeat by dot dot dot
Plug 'cohama/lexima.vim'

" fzf on Vim
Plug 'junegunn/fzf.vim'

" automatically adjusts 'shiftwidth' and 'expandtab'
Plug 'tpope/vim-sleuth'

" Multiple cursors plugin for vim/neovim
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" provides additional text objects
Plug 'wellle/targets.vim'

call plug#end()

" Options {{{1
" =======

syntax enable
filetype plugin indent on

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

set listchars=tab:\│\ ,trail:·,extends:>,precedes:<,nbsp:·

" Set langmap for russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЁХЪЖЭБЮ;ABCDEFGHIJKLMNOPQRSTUVWXYZ~{}:\\"<>
set langmap+=фисвуапршолдьтщзйкыегмцчняёхъжэбю;abcdefghijklmnopqrstuvwxyz`[]\\;'\\,.

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

" Don't try to highlight lines longer than 1000 characters.
set synmaxcol=1000

set showmatch
set matchtime=2
set nojoinspaces

set laststatus=2

set ruler
set showcmd
set noshowmode

set history=1000
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

set dictionary=/usr/share/dict/words

"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 500 files
"           | |    +--Remember up to 10000 lines in each register
"           | |    |      +--Remember up to 1MB in each register
"           | |    |      |     +--Remember last 1000 search patterns
"           | |    |      |     |     +---Remember last 1000 commands
"           | |    |      |     |     |
"           v v    v      v     v     v
set viminfo=h,'500,<10000,s1000,/1000,:1000,n~/.cache/vim/viminfo

if (has("nvim"))
  set shada=h,'500,<10000,s1000,/1000,:1000,n~/.cache/nvim/shada
endif

" Enable histogram-based diffs
" https://www.reddit.com/r/vim/comments/cn20tv/tip_histogrambased_diffs_using_modern_vim/
if has('nvim-0.3.2') || has('patch-8.1.0360')
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" Search down into subfolders
set path+=**

" Copy/paste to/from primary clipboard if available
if (has("clipboard"))
  set clipboard^=unnamed
endif

"Syntax highlighting in Markdown
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['bash=sh', 'css', 'django', 'javascript', 'js=javascript', 'json=javascript', 'perl', 'php', 'python', 'ruby', 'sass', 'xml', 'html', 'vim']

" User interface {{{1
" ==============

" set background=dark

if (has("autocmd"))
  augroup colorextend
    autocmd!
    autocmd ColorScheme * call onedark#extend_highlight("SignColumn", { "guibg": "#1b1f27", "guifg": "none" })
    autocmd ColorScheme * call onedark#extend_highlight("SignifySignAdd", { "guibg": "#121212", "guifg": "#5f8700" })
    autocmd ColorScheme * call onedark#extend_highlight("SignifySignChange", { "guibg": "#121212", "guifg": "#0087af" })
    autocmd ColorScheme * call onedark#extend_highlight("SignifySignDelete", { "guibg": "#121212", "guifg": "#870000" })
  augroup END
endif

if !exists('g:vimrcloaded')
  if &t_Co == 256
    try
      colorscheme onedark
    catch /E185/
      colorscheme desert
    endtry
  else
    colorscheme desert
  endif
  let g:vimrcloaded = 1
endif

" Fixes for minimalist theme
" highlight SpecialKey ctermfg=237 ctermbg=NONE guifg=#3A3A3A guibg=NONE
" highlight SignColumn ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212
" highlight LineNr ctermfg=237 ctermbg=233 guifg=#3A3A3A guibg=#121212

" Signify for minimalist theme
" highlight SignifySignAdd    guibg=#121212 guifg=#5f8700 ctermbg=233 ctermfg=64
" highlight SignifySignChange guibg=#121212 guifg=#0087af ctermbg=233 ctermfg=31
" highlight SignifySignDelete guibg=#121212 guifg=#870000 ctermbg=233 ctermfg=88

" Fixes for onedark theme
highlight SignColumn ctermfg=NONE ctermbg=234 guifg=NONE guibg=#1b1f27
highlight LineNr ctermfg=237 ctermbg=234 guifg=#3f4657 guibg=#1b1f27

" Signify for onedark theme
highlight SignifySignAdd    guibg=#1b1f27 guifg=#5f8700 ctermbg=234 ctermfg=64
highlight SignifySignChange guibg=#1b1f27 guifg=#0087af ctermbg=234 ctermfg=31
highlight SignifySignDelete guibg=#1b1f27 guifg=#870000 ctermbg=234 ctermfg=88

" GitGutter
highlight link GitGutterAdd SignifySignAdd
highlight link GitGutterChange SignifySignChange
highlight link GitGutterDelete SignifySignDelete
highlight link GitGutterChangeDelete GitGutterDelete

" Use 24-bit (true-color) mode in Vim/Neovim
" For Neovim 0.1.3 and 0.1.4 <https://github.com/neovim/neovim/pull/2198>
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
" For Neovim > 0.1.5 and Vim > patch 7.4.1799
" <https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162>
" Based on Vim patch 7.4.1770 (`guicolors` option)
" <https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd>
" <https://github.com/neovim/neovim/wiki/Following-HEAD#20160511>
if (has("termguicolors"))
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if has('gui_running')
  "Display Hidden Characters
  "http://en.wikipedia.org/wiki/Unicode_Geometric_Shapes
  "http://www.joelonsoftware.com/articles/Unicode.html
  set listchars=tab:▶\ ,eol:★
  set listchars+=trail:◥
  set listchars+=extends:❯
  set listchars+=precedes:❮
  "vertical splits less gap between bars
  set fillchars+=vert:│
  set guifont=Ubuntu\ Mono\ 10
  set guioptions-=m
  set guioptions-=r
  set guioptions-=L
  set guioptions-=t
  set guioptions-=T
  set guitablabel=[%N]\ %t
  set guitabtooltip=%F
  if !exists("g:gvimrcloaded")
    colorscheme final
    winpos 0 0  " default window position
    " Default windows size:
    if !&diff
      winsize 100 30
    else
      winsize 120 30
    endif
    let g:gvimrcloaded = 1
  endif
endif

if &term =~ '256color' || &term =~ 'kitty' || &term =~ 'alacritty'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

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

" Abbreviations {{{1
" ============

iabbrev @@ Sergei Eremenko (https://github.com/SmartFinn)
iabbrev fasle false
iabbrev func function
iabbrev fuction function
iabbrev funciton function
iabbrev listeneres listeners
iabbrev cancle cancel
iabbrev delcare declare
iabbrev loacl local
iabbrev ecsa esac

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

  " Highlight the screen line of the cursor in insert mode
  au InsertEnter * setlocal cursorline
  au InsertLeave * setlocal nocursorline

  " Only show colorcolumn in the current window
  au BufEnter,WinEnter * setlocal colorcolumn=+1
  au BufLeave,WinLeave * setlocal colorcolumn=0
augroup END

" Close quickfix window by q key press
augroup quickfix
  au!
  au FileType qf setlocal nowrap nolist nocursorcolumn
  au FileType qf noremap <buffer> q :close<CR>
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

" Bring up urlscan for current buffer
nmap <Leader>u :w<Home>silent <End> !urlscan<CR>

" New key mapping
" ---------------
" Create tab
map <silent> <C-W>N :tabnew<CR>

" TAB = Ctrl-W
map <Tab> <C-W>
map <S-Tab> <C-W>
noremap <Tab><Tab> <C-W>w
noremap <Tab><S-Tab> <C-W>W
noremap <S-Tab><S-Tab> <C-W>W

" Make
map <silent> <F9> :update <bar> silent! make <bar> redraw! <bar> cwindow<CR>

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

" Redraw screen and mute highlight
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Use space to jump down a page (like browsers do)...
nnoremap <Space> <PageDown>
vnoremap <Space> <PageDown>

" Disable middle mouse button in Normal and Visual modes
map <MiddleMouse> <Nop>

" Remap Ctrl+C on Esc (needed for the correct exit from insert mode)
imap <C-C> <Esc>
