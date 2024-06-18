local map = vim.keymap.set

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

-- New key mapping
--

-- Create tab
map('', '<C-W>N', '<CMD>tabnew<CR>', { desc = "Create new tab" })

-- reselect last paste
map('n', 'gp', '`[v`]', { desc = "Select pasted text" })

-- TAB = Ctrl-W
map('n', '<Tab>', '<C-W>', { desc = "Window commands", remap = false, silent = true  })
map('n', '<S-Tab>', '<C-W>', { desc = "Window commands", remap = false, silent = true })
map('n', '<Tab><Tab>', '<C-W>w', { desc = "Switch window clockwise", remap = false })
map('n', '<Tab><S-Tab>', '<C-W>W', { desc = "Switch window counter-clockwise", remap = false })
map('n', '<S-Tab><S-Tab>', '<C-W>W', { desc = "Switch window counter-clockwise", remap = false })

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
map('i', '<C-->', '<C-o>u', { desc = "Undo" })

-- Multiple cursors for poor man
-- Tip: use . (dot) to apply the changes, n/N - to skip
-- https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
map('x', 'gb', '*cgn', { remap = true })
map('x', 'gB', '*cgN', { remap = true })

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

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- Add some useful mapping for builtin terminal emulator
map('t', '<Esc>', '<C-\\><C-N>', { desc = "Come back to normal mode" })

-- Remap default maps for built-in commenting
if vim.fn.has "nvim-0.10.0" == 1 then
  -- Toggle current line using C-/
  map('n', '<C-_>', 'gcc', { desc = "Toggle comment line", remap = true })
  map('i', '<C-_>', '<CMD>normal gcc<CR>', { desc = "Toggle comment line", remap = true })
  map('x', '<C-_>', 'gc', { desc = "Toogle comment", remap = true })
  map('o', '<C-_>', 'gc', { desc = "Toogle comment", remap = true })

  -- mapping for kitty terminal
  map('n', '<C-/>', 'gcc', { desc = "Comment the current line", remap = true })
  map('i', '<C-/>', '<CMD>normal gcc<CR>', { desc = "Comment the current line", remap = true })
  map('x', '<C-/>', 'gc', { desc = "Toogle comment", remap = true })
end
