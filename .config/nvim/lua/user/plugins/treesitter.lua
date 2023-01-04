-- https://github.com/nvim-treesitter/nvim-treesitter

require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
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
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gs',
      -- NOTE: These are visual mode mappings
      node_incremental = 'gs',
      node_decremental = 'gS',
      scope_incremental = '<leader>gc',
    },
  },
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['uc'] = '@comment.outer',

        -- Or you can define your own textobjects like this
        -- ["iF"] = {
        --     python = "(function_definition) @function",
        --     cpp = "(function_definition) @function",
        --     c = "(function_definition) @function",
        --     java = "(method_declaration) @function",
        -- },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
        ['<leader>f'] = '@function.outer',
        ['<leader>e'] = '@element',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
        ['<leader>F'] = '@function.outer',
        ['<leader>E'] = '@element',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  -- https://github.com/windwp/nvim-ts-autotag
  autotag = {
    enable = true,
  },
  -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
  refactor = {
    highlight_definitions = { enable = true },
    -- highlight_current_scope = { enable = true },
  },
})

-- Tree-sitter based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
