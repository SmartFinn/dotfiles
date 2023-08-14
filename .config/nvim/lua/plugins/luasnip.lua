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
    {
      '<Tab>',
      function()
        return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<Tab>'
      end,
      expr = true, remap = true, silent = true, mode = 'i',
    },
    { '<Tab>', function() require('luasnip').jump(1) end, mode = 's' },
    { '<S-Tab>', function() require('luasnip').jump(-1) end, mode = { 'i', 's' } },
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
