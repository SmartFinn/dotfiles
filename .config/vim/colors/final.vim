" Vim color file
"
" Name:       xoria256.vim
" Version:    1.4
" Maintainer: Dmitriy Y. Zotikov (xio) <xio@ungrund.org>
"
" Should work in recent 256 color terminals.  88-color terms like urxvt are
" NOT supported.
"
" Don't forget to install 'ncurses-term' and set TERM to xterm-256color or
" similar value.
"
" Color numbers (0-255) see:
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

" Initialization {{{
if &t_Co != 256 && ! has("gui_running")
  echomsg ""
  echomsg "err: please use GUI or a 256-color terminal (so that t_Co=256 could be set)"
  echomsg ""
  finish
endif

set background=dark

hi clear
hi clear PmenuThumb

if exists("syntax_on")
  syntax reset
endif

let colors_name = "final"


"" General colors
hi Normal       ctermfg=252 guifg=#d0d0d0 ctermbg=234 guibg=#1c1c1c cterm=none gui=none
hi Cursor       ctermfg=fg  guifg=fg      ctermbg=166 guibg=#d75f00
hi CursorColumn                           ctermbg=238 guibg=#444444
hi CursorLine                             ctermbg=238 guibg=#444444 cterm=none gui=none
hi ColorColumn                            ctermbg=235 guibg=#262626 cterm=none gui=none
hi ErrorMsg     ctermfg=255 guifg=#eeeeee ctermbg=88  guibg=#870000 cterm=bold gui=bold
hi FoldColumn   ctermfg=242 guifg=#5f5f87 ctermbg=235 guibg=#262626
hi Folded       ctermfg=242 guifg=fg      ctermbg=234 guibg=#5f5f87
hi IncSearch    ctermfg=234 guifg=#1c1c1c ctermbg=223 guibg=#ffdfaf cterm=none gui=none
" hi LineNr       ctermfg=242 guifg=#6c6c6c ctermbg=235 guibg=#262626
hi LineNr       ctermfg=240 guifg=#6c6c6c ctermbg=234 guibg=#262626
hi MatchParen   ctermfg=fg  guifg=fg      ctermbg=60  guibg=#5f5f87
hi NonText      ctermfg=242 guifg=#9e9e9e ctermbg=bg  guibg=bg      cterm=none gui=none
hi Pmenu        ctermfg=252 guifg=#d0d0d0 ctermbg=60  guibg=#5f5f87
hi PmenuSbar                              ctermbg=60  guibg=#5f5f87
hi PmenuSel     ctermfg=60  guifg=#5f5f87 ctermbg=252 guibg=#d0d0d0
hi PmenuThumb                             ctermbg=96  guibg=#875f87
hi Search       ctermfg=234 guifg=#1c1c1c ctermbg=149 guibg=#afdf5f
hi SignColumn   ctermfg=225 guifg=#ffdfff ctermbg=235 guibg=#262626
hi SpecialKey   ctermfg=77  guifg=#5fdf5f
hi StatusLine                             ctermbg=239 guibg=#4e4e4e cterm=bold gui=bold
hi StatusLineNC                           ctermbg=237 guibg=#3a3a3a cterm=none gui=none
hi TabLine      ctermfg=fg  guifg=fg      ctermbg=242 guibg=#666666 cterm=none gui=none
hi TabLineFill  ctermfg=fg  guifg=fg      ctermbg=239 guibg=#4e4e4e cterm=none gui=none
hi TabLineSel   ctermfg=fg  guifg=fg      ctermbg=bg  guibg=bg      cterm=bold gui=bold
hi Title        ctermfg=225 guifg=#ffdfff
hi VertSplit    ctermfg=237 guifg=#3a3a3a ctermbg=237 guibg=#3a3a3a cterm=none gui=none
hi Visual       ctermfg=bg  guifg=bg      ctermbg=111 guibg=#87afff
hi VIsualNOS    ctermfg=bg  guifg=bg      ctermbg=111 guibg=#87afff cterm=none gui=none
hi WildMenu     ctermfg=239 guifg=#000000 ctermbg=184 guibg=#d7d700 cterm=bold gui=bold

"" Syntax highlighting {{{2
hi Comment      ctermfg=246 guifg=#949494
hi Constant     ctermfg=229 guifg=#ffffaf
hi Error        ctermfg=255 guifg=#eeeeee ctermbg=88  guibg=#870000
hi Identifier   ctermfg=182 guifg=#dfafdf                           cterm=none
hi Ignore       ctermfg=238 guifg=#444444
hi Number       ctermfg=180 guifg=#dfaf87
hi PreProc      ctermfg=150 guifg=#afdf87
hi Special      ctermfg=174 guifg=#df8787
hi Statement    ctermfg=110 guifg=#87afd7                           cterm=none gui=none
hi Todo         ctermfg=0   guifg=#000000 ctermbg=184 guibg=#dfdf00
hi Type         ctermfg=146 guifg=#afafd7                           cterm=none gui=none
hi Underlined   ctermfg=39  guifg=#00afff                           cterm=underline gui=underline

"" Spell
hi SpellBad     ctermfg=160 guifg=fg      ctermbg=bg                cterm=underline               guisp=#df0000
hi SpellCap     ctermfg=189 guifg=#d0d0ff ctermbg=bg  guibg=bg      cterm=underline gui=underline 
hi SpellRare    ctermfg=168 guifg=#d75f87 ctermbg=bg  guibg=bg      cterm=underline gui=underline 
hi SpellLocal   ctermfg=51                ctermbg=23                cterm=underline

"" Special {{{2
""" .diff {{{3
hi diffAdded    ctermfg=150 guifg=#afdf87
hi diffRemoved  ctermfg=174 guifg=#df8787
""" vimdiff {{{3
hi diffAdd      ctermfg=bg  guifg=bg      ctermbg=151 guibg=#afd7af
hi diffChange   ctermfg=bg  guifg=bg      ctermbg=181 guibg=#d7afaf
hi diffDelete   ctermfg=73  guifg=bg      ctermbg=73  guibg=#5fafaf cterm=none gui=none
hi diffText     ctermfg=bg  guifg=bg      ctermbg=174 guibg=#d78787 cterm=none gui=none

" vim:ft=vim:expandtab:tabstop=2:shiftwidth=2:smarttab:softtabstop=2
