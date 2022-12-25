-- Sample specific settings.
-- Options
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.shiftround = true
vim.opt_local.expandtab = true
vim.opt_local.foldmethod = "manual"
vim.opt_local.wrap = false

-- Compiler

-- Syntax

-- Macros

-- Mapping
vim.keymap.set({'n', 'v', 'o'}, '<F8>',
  '<CMD>!/usr/bin/env interpreter "%:p"<CR>', {
  silent = true, buffer = true,
})

vim.keymap.set({'n', 'v', 'o'}, '<F9>',
  '<CMD>update | make | redraw! | cwindow<CR>', {
  silent = true, buffer = true,
})

-- Plugins
