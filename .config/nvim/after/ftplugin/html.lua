-- HTML specific settings.
-- Options
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.shiftround = false
vim.opt_local.expandtab = false
vim.opt_local.foldmethod = "indent"
vim.opt_local.matchpairs:append("<:>")
vim.opt_local.wrap = false

-- Compiler

-- Syntax

-- Macros
-- Alphabetically sort CSS properties in file with :SortCSS
vim.api.nvim_buf_create_user_command(0, 'SortCSS',
  'g#\\({\\n\\)\\@<=#.,/}/sort', {})

-- Delete HTML tags but keeps text
vim.api.nvim_buf_create_user_command(0, 'DeleteAllTags',
  '%s#<[^>]\\+>##g', {})

-- Mapping

-- Plugins
