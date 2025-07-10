-- Pluginless config for NeoVim
-- inspired by
-- https://gitlab.com/linuxdabbler/dotfiles/-/blob/main/.config/nvim/init.lua

-- Global variables
-------------------
vim.g.mapleader = "\\" -- sets leader key
vim.g.netrw_banner = 0 -- gets rid of the annoying banner for netrw
vim.g.netrw_browse_split = 4 -- open in prior window
vim.g.netrw_altv = 1 -- change from left splitting to right splitting
vim.g.netrw_liststyle = 3 -- tree style view in netrw

-- Options
----------
vim.opt.syntax = "ON"
vim.cmd('filetype plugin on') -- set filetype
vim.opt.fileencoding = "utf-8" -- encoding set to utf-8

vim.opt.clipboard:prepend("unnamedplus") -- copy/paste to/from primary clipboard
vim.opt.viewoptions:remove "curdir" -- disable saving current directory with views

vim.opt.swapfile = false -- disable creating a swapfile
vim.opt.undofile = true -- enable persistent undo
vim.opt.writebackup = false -- if a file is being edited by another program,
                            -- it is not allowed to be edited

vim.opt.lazyredraw = true -- lazily redraw screen
vim.opt.foldenable = false -- open all fold by default

vim.opt.scrolloff = 8 -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right

vim.opt.whichwrap:append("<,>,[,]")
vim.opt.virtualedit = "block" -- allow virtual editing in Visual block mode
vim.opt.breakindent = true -- wrap indent to match  line start

vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.copyindent = true -- copy the previous indentation on autoindenting

vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case

vim.opt.synmaxcol = 1000 -- Don't try to highlight lines longer than 1000 characters

vim.opt.showmatch = true -- show the matching parenthesis
vim.opt.matchtime = 2 -- reduce seconds to show the matching parenthesis

vim.opt.path:append("**") -- search down into subfolders
vim.opt.completeopt= { "menuone", "noselect" }

-- ignore file patterns when completing files
vim.opt.wildignore = {
  ".svn", ".git", ".bzr", ".hg",
  "*~", "*.swp", "*.swo",
  "*.luac", "*.pyc", "*.rbc", "*.class", "classes",
  "*.o", "*.mo", "*.so", "*.obj",
  "*.jpg", "*.bmp", "*.gif", "*.png", "*.jpeg",
  "*.avi", "*.mkv", "*.mpg", "*.mpeg", "*.vob",
  "*.mp3", "*.ogg", "*.aac", "*.flac",
  "*.aux", "*.out", "*.toc",
  "*.exe", "*.dll", "*.manifest",
  ".sass-cache",
  ".DS_Store", "Thumbs.db",
}

vim.opt.dictionary = "/usr/share/dict/words"

-- Enable histogram-based diffs
-- https://www.reddit.com/r/vim/comments/cn20tv/tip_histogrambased_diffs_using_modern_vim/
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("indent-heuristic")
vim.opt.diffopt:remove("closeoff")

vim.opt.diffopt:append("vertical") -- always open diffs in vertical splits.

if vim.fn.has "nvim-0.9" == 1 then
  vim.opt.diffopt:append("linematch:60") -- enable linematch diff algorithm
end

-- Set langmap for Ukrainian layout
vim.opt.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКІЕГМЦЧНЯʼХЇЖЄБЮ;ABCDEFGHIJKLMNOPQRSTUVWXYZ~{}:"<>,' ..
                  "фисвуапршолдьтщзйкіегмцчня'хїжєбю;abcdefghijklmnopqrstuvwxyz`[];'\\,."

vim.opt.shada = {
  "h",     -- disable hlsearch when loading shada
  "'500",  -- remember marks for last 500 files
  "<1000", -- remember up to 1000 lines in each register
  "s1000", -- remember up to 1MB in each register
  "/1000", -- remember last 1000 search patterns
  ":1000", -- remember last 1000 commands
}

-- UI
vim.opt.title = true -- change title
vim.opt.titlestring = "nvim" -- set title line

vim.opt.pumheight = 10 -- height of the pop up menu

vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.splitbelow = true -- force all horizontal splits to go below current window

vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "·", extends = ">", precedes = "<", }
vim.opt.fillchars = { eob = " " } -- disable `~` on nonexistent lines

vim.opt.number = true -- turn on line numbers
vim.opt.relativenumber = true -- turn on relative line numbers
vim.opt.numberwidth = 3 -- set number column width to 3 {default 4}
vim.opt.cmdheight = 1 -- set height of the command-line
vim.opt.signcolumn = "auto"

-- Highlight the line number of the cursor
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.shortmess:append({ c = true }) -- hide |ins-completion-menu| messages
vim.opt.shortmess:append({ s = true, I = true }) -- disable startup message

vim.opt.termguicolors = true -- enables 24-bit RGB color
vim.cmd.colorscheme('retrobox') -- set colorscheme

-- statusline
vim.cmd "highlight StatusType guibg=#b16286 guifg=#1d2021"
vim.cmd "highlight StatusFile guibg=none guifg=#b4b4b4"
vim.cmd "highlight StatusModified guibg=#1d2021 guifg=#d3869b"
vim.cmd "highlight StatusBuffer guibg=#98971a guifg=#1d2021"
-- vim.cmd "highlight StatusLocation guibg=#458588 guifg=#1d2021"
vim.cmd "highlight StatusLocation guibg=none guifg=grey"
vim.cmd "highlight StatusNorm guibg=none guifg=white"
vim.o.statusline = ""
    .. "%#StatusType#"
    .. " %Y "
    .. "%#StatusFile#"
    .. " %F "
    .. "%#StatusModified#"
    .. " %m "
    .. "%#StatusNorm#"
    .. "%="
    .. "%#StatusBuffer#"
    .. " %n "
    .. "%#StatusLocation#"
    .. " %l:%c  %p%%"

-- Functions
------------


-- Key mappings
---------------

local map = vim.keymap.set

-- reload config
map("n", "<leader>r", ":source %<CR>", { desc = "Reload Neovim config" })

-- easy split navigation
map("n", "<A-h>", "<C-w>h", { desc = "Switch to left split" })
map("n", "<A-l>", "<C-w>l", { desc = "Switch to right split" })
map("n", "<A-j>", "<C-w>j", { desc = "Switch to bottom split" })
map("n", "<A-k>", "<C-w>k", { desc = "Switch to top split" })

-- Next/prev buffer
map("n", "<Leader>]", "<CMD>bnext<CR>", { desc = "Goto next buffer" })
map("n", "<Leader>[", "<CMD>bprev<CR>", { desc = "Goto previous buffer" })

-- Delete current buffer
map("n", "<Leader>q", "<CMD>bdelete<CR>", {
  silent = true,
  desc = "Delete current buffer",
})

-- Open netrw in 25% split in tree view
map("n", "<leader>e", ":25Lex<CR>")			-- Leader+e toggles netrw tree view

-- Automatically close brackets, parethesis, and quotes
map("i", "'", "''<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "{;", "{};<left><left>")
map("i", "/*", "/**/<left><left>")

-- Visual Maps
map("v", "<leader>s", "\"hy:%s/<C-r>h//g<left><left>", {
    desc = "Replace all instances of highlighted words",
})
map("v", "<C-s>", ":sort<CR>", { desc = "Sort highlighted text in visual mode" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move current line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move current line up" })

-- Some keybinds from Readline
map("i", "<C-A>", "<C-O>^", { desc = "Goto begin of the line" })
map("i", "<C-X><C-A>", "<C-A>", { desc = "Insert previously inserted text" })
map("c", "<C-A>", "<Home>", { desc = "Goto begin of the line" })
map("c", "<C-X><C-A>", "<C-A>", { desc = "Insert all match the pattern" })
map("i", "<C-E>", "<C-O>A", { desc = "Goto enf of the line" })
map({"i", "c"}, "<C-B>", "<Left>", { desc = "Goto backward" })
map({"i", "c"}, "<C-F>", "<Right>", { desc = "Goto forward" })
map({"n", "v", "i"}, "<M-b>", "<S-Left>", { desc = "Go a word backward" })
map({"n", "v", "i"}, "<M-f>", "<S-Right>", { desc = "Go a word forward" })
map({"n", "v", "i"}, "<M-n>", "<Down>", { desc = "Go down" })
map({"n", "v", "i"}, "<M-p>", "<Up>", { desc = "Go up" })
map("i", "<C-->", "<C-o>u", { desc = "Undo" })

-- Improve work with brackets
map("o", "(", "i(")
map("o", ")", "a(")
map("o", "[", "i[")
map("o", "]", "a[")
map("o", "{", "i{")
map("o", "}", "a{")
map("o", "<", "i<")
map("o", ">", "a<")

-- Change defaults
--

-- Vertical and horizontal split then hop to a new buffer
map("", "<C-W>s", "<CMD>new<CR>", { silent = true })
map("", "<C-W>v", "<CMD>vnew<CR>", { silent = true })

-- make Y consistent with C and D. See :help Y
map("n", "Y", "y$")

-- Don't clobber the unnamed register when pasting over text in visual mode
map("v", "p", "pgvy")

-- Go to last non-blank character (strip trailing white space)
map("v", "$", "g_")

-- Don't jump to the next search result, just highlight
map("n", "*", "*N", { desc = "Search forward for word under cursor" })
map("n", "#", "#N", { desc = "Search backword for word under cursor" })
map("n", "g*", "g*N", { desc = "Search forwards and select" })
map("n", "g#", "g#N", { desc = "Search backwards and select" })

-- Highlight the selected text without jumping
map("v", "*", 'y/\\C<C-R>"<CR>N', { silent = true })
map("v", "#", 'y?\\C<C-R>"<CR>N', { silent = true })

-- Center display after jumping
map("n", "n", "nzz", { desc = "Goto search match" })
map("n", "N", "Nzz", { desc = "Goto search match in opposite dicection" })
map("n", "g;", "g;zz", { desc =  "Go backward in change list"})
map("n", "g,", "g,zz", { desc =  "Go forward in change list"})

-- reselect visual block after indent
map("v", "<", "<gv", { desc = "unindent line" })
map("v", ">", ">gv", { desc = "indent line" })

-- Make <Backspace> act as <Delete> in Visual mode?
map("v", "<BS>", "x")

-- Make PageDown/PageUp act like Ctrl-D/Ctrl-U
map("", "<PageUp>", "<C-U>")
map("", "<PageDown>", "<C-D>")

-- j/k will move virtual lines (lines that wrap)
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { silent = true, expr = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { silent = true, expr = true })

-- Use space to jump down a page (like browsers do)...
map({"n", "v"}, "<Space>", "<PageDown>")

-- Disable middle mouse button in Normal and Visual modes
map("", "<MiddleMouse>", "<Nop>")

-- Remap Ctrl+C on Esc (needed for the correct exit from insert mode)
map("i", "<C-C>", "<Esc>")

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
