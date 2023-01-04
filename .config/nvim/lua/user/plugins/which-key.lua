-- https://github.com/folke/which-key.nvim

require("which-key").setup({
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 10,
    },
    presets = {
      -- operators = false,
      text_objects = false,
    },
  },
  window = {
    border = "rounded",
    padding = { 2, 2, 2, 2 },
  },
  disable = { filetypes = { "TelescopePrompt" } },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
})

vim.opt.timeoutlen = 500 -- reduce time of popup showing
