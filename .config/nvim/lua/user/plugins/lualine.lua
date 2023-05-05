-- https://github.com/nvim-lualine/lualine.nvim

require('lualine').setup({
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
      { 'diagnostics', symbols = { error = "󰅙 ", warn = " ", hint = "󰌵 ", info = " " }},
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
})
