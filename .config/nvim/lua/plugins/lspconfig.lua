-- LSP Support
-- https://github.com/neovim/nvim-lspconfig

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre' },
  dependencies = {
    -- LSP manager
    {
      'williamboman/mason-lspconfig.nvim',
      cmd = {
        'LspInstall',
        'LspUninstall',
      },
      opts = {
        automatic_installation = true,
      },
    },
    { 'williamboman/mason.nvim' },

    -- Standalone UI for nvim-lsp progress
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function() require('plugins.configs.lsp.servers') end,
}
