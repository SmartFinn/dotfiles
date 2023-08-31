-- LSP Support
-- https://github.com/neovim/nvim-lspconfig

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- LSP manager
    {
      'williamboman/mason-lspconfig.nvim',
      dependencies = { 'williamboman/mason.nvim' },
      cmd = {
        'LspInstall',
        'LspUninstall',
      },
      opts = {
        automatic_installation = true,
      },
    },

    -- Standalone UI for nvim-lsp progress
    {
      'j-hui/fidget.nvim',
      branch = 'legacy',
      opts = {
        text = { spinner = 'dots' },
      },
    },
  },
  config = function() require('plugins.configs.lsp.servers') end,
}
