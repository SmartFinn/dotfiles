-- https://github.com/L3MON4D3/LuaSnip

require('luasnip').config.set_config({
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})

-- Loading any vscode snippets from plugins
require('luasnip.loaders.from_vscode').lazy_load()
require("luasnip.loaders.from_vscode").load({ paths = vim.fn.stdpath("config") .. "/snippets" })

vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

-- Mappins to move around inside snippets
vim.keymap.set({ 'i', 's' }, '<C-j>', '<CMD>lua require("luasnip").jump(1)<CR>')
vim.keymap.set({ 'i', 's' }, '<C-k>', '<CMD>lua require("luasnip").jump(-1)<CR>')
