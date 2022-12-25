-- C specific settings
-- Options
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.shiftround = true
vim.opt_local.foldmethod = "indent"
vim.opt_local.textwidth = 79
vim.opt_local.wrap = false

-- Compiler
vim.opt_local.makeprg = "gcc % -o %:r"

-- Syntax

-- Macros

-- Mapping
vim.keymap.set({'n', 'v', 'o'}, '<F8>',
  '<CMD>!"%:p:r"<CR>', {
  silent = true, buffer = true,
})

vim.keymap.set({'n', 'v', 'o'}, '<F9>',
  '<CMD>update | make | redraw! | cwindow<CR>', {
  silent = true, buffer = true,
})

-- Plugins
