local function map(m, k, v, opts)
  vim.keymap.set(m, k, v, opts)
end

local function remap(m, k, v, _opts)
  _opts = _opts or {}
  local opts = { remap = true, silent = true }
  for key,val in pairs(_opts) do opts[key] = val end
  vim.keymap.set(m, k, v, opts)
end

-- Leader keys
--

-- Search & replace the word under the cursor
map('n',
  '<Leader>S',
  [[:%s/<C-R>=expand("<cword>")<CR>/<C-R>=expand("<cword>")<CR>]], {
  desc = 'Replace word under cursor'
})

map('v', '<Leader>S', [[y:%s/<C-R>"/<C-R>"]], {
  desc = 'Replace selected text',
})

-- Delete current buffer
map('n', '<Leader>q', '<CMD>bdelete<CR>', {
  silent = true,
  desc = 'Delete current buffer',
})

-- Yank to system clipboard
map('x', '<Leader>y', '"+y', { desc = "Yank to system clipboard" })

-- Paste from system clipboard
map('', '<Leader>p', '"+p', { desc = "Paste from system clipboard" })

-- Save/Load sessions
map('n', '<Leader>sl', '<CMD>SessionLoad<CR>', { desc = "Load latest session" })
map('n', '<Leader>ss', '<CMD>SessionSave<CR>', { desc = "Save current session" })

-- New key mapping
--

-- Create tab
map('', '<C-W>N', '<CMD>tabnew<CR>', { desc = "Create new tab" })

-- reselect last paste
map('n', 'gp', '`[v`]', { desc = "Select pasted text" })

-- TAB = Ctrl-W
remap('', '<Tab>', '<C-W>', { desc = "Window commands" })
remap('', '<S-Tab>', '<C-W>', { desc = "Window commands" })
map('n', '<Tab><Tab>', '<C-W>w', { desc = "Switch window clockwise" })
map('n', '<Tab><S-Tab>', '<C-W>W', { desc = "Switch window counter-clockwise" })
map('n', '<S-Tab><S-Tab>', '<C-W>W', { desc = "Switch window counter-clockwise" })

-- Some keybinds from Readline
map('i', '<C-A>', '<C-O>^', { desc = "Goto begin of the line" })
map('i', '<C-X><C-A>', '<C-A>', { desc = "Insert previously inserted text" })
map('c', '<C-A>', '<Home>', { desc = "Goto begin of the line" })
map('c', '<C-X><C-A>', '<C-A>', { desc = "Insert all match the pattern" })
map('i', '<C-E>', '<C-O>A', { desc = "Goto enf of the line" })
map({'i', 'c'}, '<C-B>', '<Left>', { desc = "Goto backward" })
map({'i', 'c'}, '<C-F>', '<Right>', { desc = "Goto forward" })
map({'n', 'v', 'i'}, '<M-b>', '<S-Left>', { desc = "Go a word backward" })
map({'n', 'v', 'i'}, '<M-f>', '<S-Right>', { desc = "Go a word forward" })
map({'n', 'v', 'i'}, '<M-n>', '<Down>', { desc = "Go down" })
map({'n', 'v', 'i'}, '<M-p>', '<Up>', { desc = "Go up" })

-- Toogle options (vim-unimpaired replacement)
map('', 'Zc', '<CMD>setlocal cursorline!<CR>', { desc = "Toggle cursorline" })
map('', 'Zh', '<CMD>setlocal hlsearch!<CR>', { desc = "Toggle hlsearch" })
map('', 'Zi', '<CMD>setlocal ignorecase!<CR>', { desc = "Toggle ignorecase" })
map('', 'Zl', '<CMD>setlocal list!<CR>', { desc = "Toggle list" })
map('', 'Zn', '<CMD>setlocal number!<CR>', { desc = "Toggle number" })
map('', 'Zr', '<CMD>setlocal relativenumber!<CR>', { desc = "Toggle relativenumber" })
map('', 'Zs', '<CMD>setlocal spell!<CR>', { desc = "Toggle spell" })
map('', 'Zu', '<CMD>setlocal cursorcolumn!<CR>', { desc = "Toggle cursorcolumn" })
map('', 'Zw', '<CMD>setlocal wrap!<CR>', { desc = "Toggle wrap" })

-- Switch options (vim-unimpaired replacement)
map('', '[ob', '<CMD>set backgroud=dark<CR>', { desc = "Set dark background" })
map('', ']ob', '<CMD>set backgroud=light<CR>', { desc = "Set light background" })
map('', '[oc', '<CMD>setlocal nocursorline<CR>', { desc = "Disable cursorline" })
map('', ']oc', '<CMD>setlocal cursorline<CR>', { desc = "Enable cursorline" })
map('', '[od', '<CMD>diffoff<CR>', { desc = "Disable diff" })
map('', ']od', '<CMD>diffthiss<CR>', { desc = "Enable diff" })
map('', '[oh', '<CMD>setlocal nohlsearch<CR>', { desc = "Disable hlsearch" })
map('', ']oh', '<CMD>setlocal hlsearch<CR>', { desc = "Enable hlsearch" })
map('', '[oi', '<CMD>setlocal noignorecase<CR>', { desc = "Disable ignorecase" })
map('', ']oi', '<CMD>setlocal ignorecase<CR>', { desc = "Enable ignorecase" })
map('', '[ol', '<CMD>setlocal nolist<CR>', { desc = "Disable list" })
map('', ']ol', '<CMD>setlocal list<CR>', { desc = "Enable list" })
map('', '[on', '<CMD>setlocal nonumber<CR>', { desc = "Disable number" })
map('', ']on', '<CMD>setlocal number<CR>', { desc = "Enable number" })
map('', '[or', '<CMD>setlocal norelativenumber<CR>', { desc = "Disable relativenumber" })
map('', ']or', '<CMD>setlocal relativenumber<CR>', { desc = "Enable relativenumber" })
map('', '[ol', '<CMD>setlocal nospell<CR>', { desc = "Disable spell" })
map('', ']ol', '<CMD>setlocal spell<CR>', { desc = "Enable spell" })
map('', '[ot', '<CMD>setlocal colorcolumn=0<CR>', { desc = "Disable colorcolumn" })
map('', ']ot', '<CMD>setlocal colorcolumn=+1<CR>', { desc = "Enable colorcolumn" })
map('', '[ou', '<CMD>setlocal nocursorcolumn<CR>', { desc = "Disable cursorcolumn" })
map('', ']ou', '<CMD>setlocal cursorcolumn<CR>', { desc = "Enable cursorcolumn" })
map('', '[ov', '<CMD>setlocal virtualedit-=all<CR>', { desc = "Disable virtualedit" })
map('', ']ov', '<CMD>setlocal virtualedit+=all<CR>', { desc = "Enable virtualedit" })
map('', '[ow', '<CMD>setlocal nowrap<CR>', { desc = "Disable wrap" })
map('', ']ow', '<CMD>setlocal wrap<CR>', { desc = "Enable wrap" })

-- Actions (vim-unimpaired replacement)
map('', '[a', '<CMD>previous<CR>', { desc = "Go to previous file" })
map('', ']a', '<CMD>next<CR>', { desc = "Go to next file" })
map('', '[A', '<CMD>first<CR>', { desc = "Go to first file" })
map('', ']A', '<CMD>last<CR>', { desc = "Go to last file" })
map('', '[b', '<CMD>bprevious<CR>', { desc = "Go to previous buffer" })
map('', ']b', '<CMD>bnext<CR>', { desc = "Go to next buffer" })
map('', '[B', '<CMD>bfirst<CR>', { desc = "Go to first buffer" })
map('', ']B', '<CMD>blast<CR>', { desc = "Go to last buffer" })
map('n', '[e', '<CMD>move-2<CR>', { desc = "Move the current line above" })
map('n', ']e', '<CMD>move+<CR>', { desc = "Move the current line below" })
map('v', '[e', [[:move '<-2<CR>gv=gv]], { desc = "Move the selected lines above" })
map('v', ']e', [[:move '>+1<CR>gv=gv]], { desc = "Move the selected lines below" })
map('', '[l', '<CMD>lprevious<CR>', { desc = "Go to previous location list item" })
map('', ']l', '<CMD>lnext<CR>', { desc = "Go to next location list item" })
map('', '[L', '<CMD>lfirst<CR>', { desc = "Go to first location list item" })
map('', ']L', '<CMD>llast<CR>', { desc = "Go to last location list item" })
map('', '[q', '<CMD>cprevious<CR>', { desc = "Jump to previous error" })
map('', ']q', '<CMD>cnext<CR>', { desc = "Jump to next error" })
map('', '[Q', '<CMD>cfirst<CR>', { desc = "Jump to first error" })
map('', ']Q', '<CMD>clast<CR>', { desc = "Jump to last error" })
map('', '[t', '<CMD>tprevious<CR>', { desc = "Jump to previous tag" })
map('', ']t', '<CMD>tnext<CR>', { desc = "Jump to next tag" })
map('', '[T', '<CMD>tfirst<CR>', { desc = "Jump to first tag" })
map('', ']T', '<CMD>tlast<CR>', { desc = "Jump to last tag" })

-- Improve work with brackets
map('o', '(', 'i(')
map('o', ')', 'a(')
map('o', '[', 'i[')
map('o', ']', 'a[')
map('o', '{', 'i{')
map('o', '}', 'a{')
map('o', '<', 'i<')
map('o', '>', 'a<')


-- Change defaults
--

-- Vertical and horizontal split then hop to a new buffer
map('', '<C-W>s', '<CMD>new<CR>', { silent = true })
map('', '<C-W>v', '<CMD>vnew<CR>', { silent = true })

-- make Y consistent with C and D. See :help Y
map('n', 'Y', 'y$')

-- Don't clobber the unnamed register when pasting over text in visual mode
map('v', 'p', 'pgvy')

-- Go to last non-blank character (strip trailing white space)
map('v', '$', 'g_')

-- Don't jump to the next search result, just highlight
map('n', '*', '*N', { desc = "Search forward for word under cursor" })
map('n', '#', '#N', { desc = "Search backword for word under cursor" })
map('n', 'g*', 'g*N', { desc = "Search forwards and select" })
map('n', 'g#', 'g#N', { desc = "Search backwards and select" })

-- Highlight the selected text without jumping
map('v', '*', 'y/\\C<C-R>"<CR>N', { silent = true })
map('v', '#', 'y?\\C<C-R>"<CR>N', { silent = true })

-- Center display after jumping
map('n', 'n', 'nzz', { desc = "Goto search match" })
map('n', 'N', 'Nzz', { desc = "Goto search match in opposite dicection" })
map('n', 'g;', 'g;zz', { desc =  "Go backward in change list"})
map('n', 'g,', 'g,zz', { desc =  "Go forward in change list"})

-- Quick macro to the q registry, use Q to play back
map('n', 'Q', '@q')

-- reselect visual block after indent
map('v', '<', '<gv', { desc = "unindent line" })
map('v', '>', '>gv', { desc = "indent line" })

-- Make <Backspace> act as <Delete> in Visual mode?
map('v', '<BS>', 'x')

-- Make PageDown/PageUp act like Ctrl-D/Ctrl-U
map('', '<PageUp>', '<C-U>')
map('', '<PageDown>', '<C-D>')

-- j/k will move virtual lines (lines that wrap)
map({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { silent = true, expr = true })
map({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { silent = true, expr = true })

-- Use space to jump down a page (like browsers do)...
map({'n', 'v'}, '<Space>', '<PageDown>')

-- Disable middle mouse button in Normal and Visual modes
map('', '<MiddleMouse>', '<Nop>')

-- Remap Ctrl+C on Esc (needed for the correct exit from insert mode)
map('i', '<C-C>', '<Esc>')
