-- Python specific settings
-- Options
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.shiftround = true
vim.opt_local.expandtab = true
vim.opt_local.foldmethod = "indent"
vim.opt_local.textwidth = 79
vim.opt_local.wrap = fasle

-- Compiler

-- Syntax
-- Display tabs at the beginning of a line in Python mode as bad.
vim.cmd [[ syntax match pythonError /^\t\+/ ]]

-- Make trailing whitespace be flagged as bad.
vim.cmd [[ syntax match pythonError /\s\+$/ ]]

-- Macros

-- Mapping
vim.keymap.set({'n', 'v', 'o'}, '<F8>',
  '<CMD>!/usr/bin/env python "%:p"<CR>', {
  silent = true, buffer = true,
})

-- Plugins
vim.g.python_highlight_all = 1
