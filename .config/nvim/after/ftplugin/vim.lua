-- Vim specific settings.
-- Options
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.shiftround = true
vim.opt_local.expandtab = true
vim.opt_local.foldmethod = "marker"
vim.opt_local.wrap = false

-- Compiler

-- Mapping
vim.keymap.set({'n', 'v', 'o'}, '<F8>',
  '<CMD>source "%:p"<CR>', {
  silent = true, buffer = true,
})

-- Syntax

-- Macros

-- Plugins
