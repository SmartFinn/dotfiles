-- ZSH specific settings.
-- Options
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.shiftround = false
vim.opt_local.expandtab = false
vim.opt_local.foldmethod = "indent"
vim.opt_local.textwidth = 96
vim.opt_local.wrap = false

-- Compiler

-- Syntax

-- Macros

-- Mapping
vim.keymap.set({'n', 'v', 'o'}, '<F8>',
  '<CMD>!/usr/bin/env zsh "%:p"<CR>', {
  silent = true, buffer = true,
})

-- Plugins
