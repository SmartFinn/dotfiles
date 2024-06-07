-- :help options
vim.opt.clipboard:prepend("unnamed") -- copy/paste to/from primary clipboard

vim.opt.viewoptions:remove "curdir" -- disable saving current directory with views

vim.opt.swapfile = false -- disable creating a swapfile
vim.opt.undofile = true -- enable persistent undo
vim.opt.writebackup = false -- if a file is being edited by another program, it is not allowed to be edited

vim.opt.lazyredraw = false -- lazily redraw screen
vim.opt.foldenable = false -- open all fold by default

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 15

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

vim.opt.showmatch = true -- show the matching paren
vim.opt.matchtime = 2 -- reduce seconds to show the matching paren.

vim.opt.path:append("**") -- search down into subfolders

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
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.splitbelow = true -- force all horizontal splits to go below current window

vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "·", extends = ">", precedes = "<", }
vim.opt.fillchars = { eob = " " } -- disable `~` on nonexistent lines

-- vim.opt.numberwidth = 2 -- set number column width to 2 {default 4}
vim.opt.cmdheight = 0 -- hide the command-line

vim.opt.pumheight = 10 -- height of the pop up menu

-- Highlight the line number of the cursor
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.termguicolors = true -- set term gui colors (most terminals support this)

vim.opt.confirm = true -- asking instead of fail

vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.shortmess:append({ c = true }) -- hide |ins-completion-menu| messages
vim.opt.shortmess:append({ s = true, I = true }) -- disable startup message
