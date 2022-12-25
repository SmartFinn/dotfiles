-- Markdown specific settings.
-- Options
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.shiftround = true
vim.opt_local.expandtab = true
vim.opt_local.foldmethod = "manual"
vim.opt_local.wrap = true

-- Compiler
vim.opt_local.makeprg = "pandoc -f markdown -t html -o \"%:p:r.html\" \"%:p\""

-- Syntax
vim.g.markdown_fenced_languages = {
  'bash=sh', 'css', 'django', 'javascript', 'js=javascript',
  'json=javascript', 'lua', 'perl', 'php', 'python', 'ruby',
  'sass', 'xml', 'html', 'viml=vim',
}

-- Macros

-- Mapping
vim.keymap.set({'n', 'v', 'o'}, '<F9>',
  '<CMD>update | make | redraw! | cwindow<CR>', {
  silent = true, buffer = true, })

-- Plugins
