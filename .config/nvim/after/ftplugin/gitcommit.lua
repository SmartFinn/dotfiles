-- gitcommit specific settings.
-- Options
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.shiftround = true
vim.opt_local.expandtab = true
vim.opt_local.foldmethod = "indent"
vim.opt_local.wrap = false
vim.opt_local.spell = true

-- Compiler

-- Syntax

-- Macros
vim.api.nvim_create_autocmd({"BufEnter"}, {
  buffer = 0,
 command = "normal! 1G",
})

-- Mapping

-- Plugins
