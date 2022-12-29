-- https://github.com/nvim-treesitter/nvim-treesitter

local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

ts.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "lua",
    "javascript",
    "json",
    "python",
    "yaml",
  },

  ignore_install = { "php" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KiB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    disable = { "html", },
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },

  autotag = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = false },
}

-- Tree-sitter based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
