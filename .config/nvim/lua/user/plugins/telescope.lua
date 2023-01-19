-- https://github.com/nvim-telescope/telescope.nvim

local actions = require('telescope.actions')
local lactions = require('telescope.actions.layout')
local finders = require('telescope.builtin')
local fb_actions = require('telescope').extensions.file_browser.actions

require('telescope').setup({
  defaults = {
    prompt_prefix = ' ❯ ',
    initial_mode = 'insert',
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
    },
    mappings = {
      ['i'] = {
        ['<C-c>'] = actions.close,
        ['<C-Bslash>'] = lactions.toggle_preview,
      },
      ['n'] = {
        ['q'] = actions.close,
        ['<C-c>'] = actions.close,
        ['<C-Bslash>'] = lactions.toggle_preview,
      },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
      hidden = true, -- show hidden (dot) files
      select_buffer = true,
      grouped = true, -- dirs before files
      mappings = {
        ['i'] = {
          ['<C-u>'] = fb_actions.goto_parent_dir,
        },
        ['n'] = {
          ['<BS>'] = fb_actions.goto_parent_dir,
        },
      },
    },
  },
})

-- https://github.com/nvim-telescope/telescope-file-browser.nvim
require("telescope").load_extension("file_browser")

local file_browser = require('telescope').extensions.file_browser.file_browser

local find_dotfiles = function()
  finders.find_files({
    find_command = { 'dotbare', 'ls-files' },
  })
end

local find_files = function()
  local is_git_repo = pcall(finders.git_files, { show_untracked = true })
  if not is_git_repo then
    finders.find_files()
  end
end

vim.keymap.set('n', '<Leader>ff', find_files, { desc = "Find files" })
vim.keymap.set('n', '<Leader>fr', finders.oldfiles, { desc = "Recent files" })
vim.keymap.set('n', '<Leader>fw', finders.live_grep, { desc = "Grep" })
vim.keymap.set('n', '<Leader>fb', finders.buffers, { desc = "Buffers" })
vim.keymap.set('n', '<Leader>fh', finders.help_tags, { desc = "Help tags" })
vim.keymap.set('n', '<Leader>fd', find_dotfiles, { desc = "Dotfiles" })
vim.keymap.set('n', '<Leader>e', file_browser, { desc = "Open file browser" })
vim.keymap.set('n', '-', file_browser, { desc = "Open file browser" })
