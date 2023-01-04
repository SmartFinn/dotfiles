local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({
    "git", "clone", "--depth", "1",
    "https://github.com/wbthomason/packer.nvim", install_path
  })
	print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

local status, packer = pcall(require, "packer")
if not status then
  vim.notify("Packer is not installed")
  return
end

packer.init({
  compile_path = vim.fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
  display = {
    -- Using a floating window
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end
  },
})

packer.startup(function(use)
  -- Packer can manage itself
  use({ 'wbthomason/packer.nvim' })

  -- Fuzzy Finder (files, lsp, etc)
  use({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('user.plugins.telescope') end,
  })

  -- Telescope File browser extention
  use({ 'nvim-telescope/telescope-file-browser.nvim' })

  -- Treesitter configurations and abstraction layer for Neovim
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    config = function() require('user.plugins.treesitter') end,
  })

  -- Refactor module for nvim-treesitter
  use({
    'nvim-treesitter/nvim-treesitter-refactor',
    after = 'nvim-treesitter',
  })

  -- Syntax aware text-objects, select, move, swap, and peek support
  use({
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  })

  -- Rainbow parentheses for neovim using tree-sitter
  use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })

  -- Autoclose tags
  use({ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' })

  -- Add/delete/change surrounding pairs
  use({
    'kylechui/nvim-surround',
    tag = 'v1.0.0',
    config = function() require('nvim-surround').setup() end
  })

  -- Commenting
  use({
    'numToStr/Comment.nvim',
    config = function() require('user.plugins.comment') end,
    requires = {
      -- Neovim treesitter plugin for setting the commentstring based on
      -- the cursor location in a file
      'JoosepAlviste/nvim-ts-context-commentstring',
    }
  })

  -- Autopairs
  use({
    'windwp/nvim-autopairs',
    event = 'InsertCharPre',
    config = function() require('user.plugins.autopairs') end
  })

  -- Keymap popup
  use({
    'folke/which-key.nvim',
    config = function () require('user.plugins.which-key') end,
  })

  -- Colorscheme
  use({
    'navarasu/onedark.nvim',
    config = function() require('user.plugins.onedark') end,
  })

  -- Status line
  use({
    'nvim-lualine/lualine.nvim',
    config = function() require('user.plugins.lualine') end,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })

  -- Bufferline
  use({
    'akinsho/bufferline.nvim',
    tag = 'v3.*',
    config = function() require('user.plugins.bufferline') end,
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  })

  -- Indent detection
  use({
    'Darazaki/indent-o-matic',
    config = function() require('user.plugins.indent-o-matic') end,
  })

  -- Indent guides
  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('user.plugins.indent-blankline') end,
  })

  -- Dashboard
  use({
    'glepnir/dashboard-nvim',
    config = function () require('user.plugins.dashboard') end,
  })

  -- Improve the default vim.ui interfaces
  use({ 'stevearc/dressing.nvim' })

  -- Notification manager
  use({
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup({ stages = "fade" })
    end,
  })

  -- Package Manager
  use({
    'williamboman/mason.nvim',
    config = function() require('mason').setup() end,
  })

  -- LSP Support
  use({
    'neovim/nvim-lspconfig',
    config = function() require('user.plugins.lsp.servers') end,
    requires = {
      -- LSP manager
      {
        'williamboman/mason-lspconfig.nvim',
        -- config = function() require('mason-lspconfig').setup() end,
      },

      { 'hrsh7th/cmp-nvim-lsp' },

      -- Standalone UI for nvim-lsp progress
      {
        'j-hui/fidget.nvim',
        config = function() require('fidget').setup({
          text = { spinner = 'dots' }
        }) end,
      },
    }
  })

  -- Autocompletion
  use({
    'hrsh7th/nvim-cmp',
    config = function() require('user.plugins.lsp.nvim-cmp') end,
    requires = {
      -- Autocompletion extras
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
    }
  })

  -- Snippets
  use({
    'L3MON4D3/LuaSnip',
    config = function() require('user.plugins.lsp.luasnip') end
  })
  use({
    'rafamadriz/friendly-snippets',
    event = 'CursorHold',
  })

  -- Formatting and linting
  use({
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufRead',
    config = function() require('user.plugins.lsp.null-ls') end,

    -- null-ls manager
    requires = {
      'jayp0521/mason-null-ls.nvim',
      config = function() require('mason-null-ls').setup() end
    }
  })
end)
