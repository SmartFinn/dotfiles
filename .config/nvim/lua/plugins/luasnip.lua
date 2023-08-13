-- Snippets
-- https://github.com/L3MON4D3/LuaSnip

return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = "make install_jsregexp", -- luajit-devel package required
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  event = 'InsertEnter',
  keys = {
    -- Mappins to move around inside snippets
    { '<C-j>', '<CMD>lua require("luasnip").jump(1)<CR>', mode = { 'i', 's' }, silent = true },
    { '<C-k>', '<CMD>lua require("luasnip").jump(-1)<CR>', mode = { 'i', 's' }, silent = true },
  },
  cmd = {
    'LuaSnipEdit',
    'LuaSnipListAvailable',
    'LuaSnipUnlinkCurrent',
  },
  config = function()
    require('luasnip').config.set_config({
      region_check_events = 'InsertEnter',
      delete_check_events = 'InsertLeave'
    })

    -- Loading any vscode snippets from plugins
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })

    vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]
  end,
}
