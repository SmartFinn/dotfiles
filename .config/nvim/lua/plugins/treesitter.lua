-- Treesitter configurations and abstraction layer for Neovim
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  version = 'v0.*',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })()
  end,
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = {
    'TSBufDisable',
    'TSBufEnable',
    'TSBufToggle',
    'TSDisable',
    'TSEnable',
    'TSToggle',
    'TSInstall',
    'TSInstallInfo',
    'TSInstallSync',
    'TSModuleInfo',
    'TSUninstall',
    'TSUpdate',
    'TSUpdateSync',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      -- A list of parser names, or "all"
      ensure_installed = {
        'bash',
        'css',
        'dockerfile',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'vimdoc',
        'yaml',
      },

      ignore_install = { 'php' },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- disable slow treesitter highlight for large files
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KiB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end

          -- disable treesitter highlight for filetypes
          return { 'htmldjango', }
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<Space>',
          -- NOTE: These are visual mode mappings
          node_incremental = '<Space>',
          node_decremental = '<Backspace>',
          scope_incremental = false,
        },
      },
    })
  end,
  init = function()
    -- Tree-sitter based folding
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
}
