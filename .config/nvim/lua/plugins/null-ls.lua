-- Formatting and linting
-- https://github.com/nvimtools/none-ls.nvim

return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- Package Manager
    { 'williamboman/mason.nvim' },

    -- Extra sources
    -- https://github.com/nvimtools/none-ls.nvim/issues/58
    { 'gbprod/none-ls-shellcheck.nvim' },
    { 'nvimtools/none-ls-extras.nvim' },

    -- null-ls manager
    -- https://github.com/jayp0521/mason-null-ls.nvim
    {
      'jayp0521/mason-null-ls.nvim',
      cmd = {
        'NullLsInstall',
        'NullLsUninstall',
      },
      opts = {
        automatic_installation = true,
      },
    },
  },
  cmd = {
    'NullLsInfo',
    'NullLsLog',
  },
  config = function()
    local null_ls = require('null-ls')

    local fmt = null_ls.builtins.formatting
    local dgn = null_ls.builtins.diagnostics
    local cda = null_ls.builtins.code_actions

    -- Configuring null-ls
    null_ls.setup({
      sources = {
        ----------------
        -- FORMATTING --
        ----------------
        fmt.shfmt.with({
          extra_args = { '-i', 0, '-ci', '-sr' },
        }),
        -----------------
        -- DIAGNOSTICS --
        -----------------
        require("none-ls-shellcheck.diagnostics"),
        ------------------
        -- CODE ACTIONS --
        ------------------
        require("none-ls-shellcheck.code_actions"),
      },
    })
  end,
}
