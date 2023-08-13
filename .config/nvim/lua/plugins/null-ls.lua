-- Formatting and linting
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- NOTE: this plugin is going to deprecate

return {
  'jose-elias-alvarez/null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    -- Package Manager
    { 'williamboman/mason.nvim' },

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
        fmt.trim_whitespace.with({
          filetypes = { 'sh', 'zsh', 'toml', 'yaml', 'make', 'conf', 'tmux' },
        }),
        fmt.shfmt.with({
          extra_args = { '-i', 0, '-ci', '-sr' },
        }),
        -----------------
        -- DIAGNOSTICS --
        -----------------
        dgn.shellcheck,
        ------------------
        -- CODE ACTIONS --
        ------------------
        cda.shellcheck,
      },
    })
  end,
}
