-- Keymap popup
-- https://github.com/folke/which-key.nvim

return {
  'folke/which-key.nvim',
  version = 'v1.*',
  event = 'UIEnter',
  init = function()
    vim.opt.timeoutlen = 500 -- reduce time of popup showing
  end,
  opts = {
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 10,
      },
      presets = {
        text_objects = false,
      },
    },
    window = {
      border = "rounded",
      padding = { 2, 2, 2, 2 },
    },
    disable = { filetypes = { "TelescopePrompt" } },
  },
}
