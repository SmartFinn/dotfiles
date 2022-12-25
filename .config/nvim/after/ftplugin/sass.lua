-- SASS specific settings.
-- Options
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.shiftround = true
vim.opt_local.expandtab = true
vim.opt_local.foldmethod = "indent"
vim.opt_local.wrap = false

-- Compiler
vim.opt_local.makeprg = "sass \"%:p\" \"%:p:r.css\""
vim.opt_local.errorformat = "%ESyntax %trror:%m,%C        on line %l of %f,%Z%m"

-- Syntax

-- Macros

-- Mapping
vim.keymap.set({'n', 'v', 'o'}, '<F9>',
  '<CMD>update | make | redraw! | cwindow<CR>', {
  silent = true, buffer = true,
})

-- Plugins
