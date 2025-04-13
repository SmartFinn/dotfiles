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

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local function mixed_indent()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then return '' end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
     return mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
  local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
  if space_indent_cnt > tab_indent_cnt then
    return tab_indent
  else
    return space_indent
  end
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'UIEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'Isrothy/lualine-diagnostic-message',
  },
  opts = {
    options = {
      theme = 'onedark',
      icons_enabled = true,
      globalstatus = true,
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      disabled_filetypes = { 'dashboard', 'snacks_dashboard' },
    },
    sections = {
      lualine_a = {
        { 'mode', color = { gui = 'bold' } },
      },
      lualine_b = {
        { 'b:gitsigns_head', icon = '' },
        { 'diff', symbols = U.diff_symbols, source = diff_source },
      },
      lualine_c = {
        { 'filename', file_status = true },
        {
          'diagnostics',
          symbols = U.sings,
          update_in_insert = false,
        },
        {
          'diagnostic-message',
          icons = U.sings,
        },
      },
      lualine_x = {
        'searchcount',
        {
          'macro-recording',
          fmt = show_macro_recording,
          icon = '⏺',
          color = { fg = 'red2' },
        },
        'filetype',
        'encoding',
        'fileformat',
      },
      lualine_y = {
        {
          mixed_indent,
          icon = '󰞘',
          color = { bg = 'red2', fg = 'black', gui = 'bold' },
        },
        'progress',
      },
      lualine_z = {
        'selectioncount',
        { 'location', color = { gui = 'bold' } },
      },
    },
    extensions = { 'quickfix', },
  },
}
