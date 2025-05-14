-- LSP Support
-- https://github.com/neovim/nvim-lspconfig

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre' },
  dependencies = {
    -- LSP manager
    {
      'mason-org/mason-lspconfig.nvim',
      version = 'v1.*',
      cmd = {
        'LspInstall',
        'LspUninstall',
      },
      opts = {
        automatic_installation = true,
      },
    },
    { 'mason-org/mason.nvim' },

    -- Standalone UI for nvim-lsp progress
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function() require('plugins.configs.lsp.servers') end,
}
