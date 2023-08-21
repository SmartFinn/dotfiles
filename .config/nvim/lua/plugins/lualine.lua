-- Status line
-- https://github.com/nvim-lualine/lualine.nvim

local U = require('plugins.configs.lsp.utils')

local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "@" .. recording_register
  end
end

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
        {
          "macro-recording",
          fmt = show_macro_recording,
          icon = '⏺',
          color = { fg = 'red2' },
        },
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
