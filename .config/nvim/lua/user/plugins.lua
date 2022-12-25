local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({
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

local au_plugins = vim.api.nvim_create_augroup("plugins_config", { clear = true })
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  desc = "Reloads Neovim after whenever you save plugins.lua",
  group = au_plugins,
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile"
})

packer.startup(function(use)
  -- Packer can manage itself
  use({ 'wbthomason/packer.nvim' })

  -- Configurations for Nvim LSP
  use({ 'neovim/nvim-lspconfig' })

  -- Fuzzy Finder (files, lsp, etc)
  use({
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  })

  -- Treesitter configurations and abstraction layer for Neovim
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true })() end,
  })

  -- Neovim treesitter plugin for setting the commentstring based on
  -- the cursor location in a file
  use({'JoosepAlviste/nvim-ts-context-commentstring'})

  -- Add/delete/change surrounding pairs
  use({
    'kylechui/nvim-surround',
    tag = 'v1.0.0',
    config = function() require('nvim-surround').setup() end
  })

  -- Commenting
  use({ 'numToStr/Comment.nvim' })

  -- Autopairs
  -- https://github.com/windwp/nvim-autopairs
  use({
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function() require("nvim-autopairs").setup() end
  })

  -- Keymap popup
  use({ 'folke/which-key.nvim' })

  -- Colorscheme
  use({ 'navarasu/onedark.nvim' })

  -- Status line
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })

  -- Bufferline
  use({
    'akinsho/bufferline.nvim',
    tag = 'v3.*',
    requires = { 'nvim-tree/nvim-web-devicons' },
  })

  -- Indent detection
  use({ 'Darazaki/indent-o-matic' })

  -- Indent guides
  use({ 'lukas-reineke/indent-blankline.nvim' })
end)
