-- Shell specific settings.
-- Options
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.shiftround = false
vim.opt_local.expandtab = false
vim.opt_local.foldmethod = "indent"
vim.opt_local.textwidth = 96
vim.opt_local.wrap = false
vim.opt_local.commentstring = "#%s"

-- Compiler
vim.opt_local.makeprg = "sed -r -f \"%:p\""
vim.opt_local.errorformat = "sed: file %f line %l: %m"

-- Syntax

-- Macros

-- Mapping
vim.keymap.set({'n', 'v', 'o'}, '<F9>',
  '<CMD>update | make | redraw! | cwindow<CR>', {
  silent = false, buffer = true,
})

-- Plugins
