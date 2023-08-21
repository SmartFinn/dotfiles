-- help specific settings.
-- Options
vim.opt_local.tabstop = 8
vim.opt_local.shiftwidth = 8
vim.opt_local.shiftround = false
vim.opt_local.expandtab = false
vim.opt_local.foldmethod = "indent"
vim.opt_local.wrap = false
vim.opt_local.cursorcolumn = false
vim.opt_local.number = false
vim.opt_local.foldenable = false
vim.opt_local.relativenumber = false
vim.opt_local.colorcolumn = "0"
vim.opt_local.textwidth = 0

-- Compiler

-- Macros

-- Mapping
vim.keymap.set('n', 'q', '<CMD>bdelete<CR>', { buffer = true, silent = true })
vim.keymap.set('n', '<CR>', '<C-]>', { buffer = true, silent = true })
vim.keymap.set('n', '<BS>', '<C-T>', { buffer = true, silent = true })

-- Plugins
