-- Autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    fast_wrap = {},
    disable_filetype = { 'TelescopePrompt', 'snacks_picker_input', 'vim' },
  },
}
