-- CSS3 specific settings.
-- Options
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.shiftround = true
vim.opt_local.expandtab = true
vim.opt_local.foldmethod = "indent"
vim.opt_local.wrap = false

-- Compiler

-- Syntax
vim.cmd [[ syntax match cssComment "//.*$" contains=@Spell ]]

-- Macros
-- Alphabetically sort CSS properties in file with :SortCSS
vim.api.nvim_buf_create_user_command(0, 'SortCSS',
  'g#\\({\\n\\)\\@<=#.,/}/sort', {})

-- Mapping

-- Plugins
