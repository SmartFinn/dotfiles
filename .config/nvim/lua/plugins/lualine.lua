-- Status line
-- https://github.com/nvim-lualine/lualine.nvim

local U = require('plugins.configs.lsp.utils')

return {
  'nvim-lualine/lualine.nvim',
  event = 'UIEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons', },
  opts = {
    options = {
      theme = 'onedark',
      icons_enabled = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        { 'mode', color = { gui = 'bold' } },
      },
      lualine_b = {
        { 'branch' },
        { 'diff', colored = false },
      },
      lualine_c = {
        { 'filename', file_status = true },
        { 'diagnostics', symbols = U.sings },
      },
      lualine_x = {
        'filetype',
        'encoding',
        'fileformat',
      },
      lualine_y = {
        'progress',
      },
      lualine_z = {
        { 'location', color = { gui = 'bold' } },
      },
    },
    extensions = { 'quickfix', },
  },
}
