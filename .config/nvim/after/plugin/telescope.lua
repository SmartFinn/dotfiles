-- https://github.com/nvim-telescope/telescope.nvim

local status, telescope = pcall(require, 'telescope')
if not status then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true, -- disables netrw and use telescope-file-browser in its place
      hidden = true, -- show hidden (dot) files
      select_buffer = true,
      grouped = true, -- dirs before files
      collapse_dirs = true, -- ship dirs with only single subdir
      mappings = {
        ["i"] = {
          ["<C-u>"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
        },
        ["n"] = {
          ["<BS>"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
        },
      },
    },
  },
})

-- https://github.com/nvim-telescope/telescope-file-browser.nvim
require("telescope").load_extension("file_browser")

local builtin = require('telescope.builtin')
local file_browser = telescope.extensions.file_browser.file_browser
local open_dotfiles = function()
  builtin.find_files({
    find_command = { 'dotbare', 'ls-files' },
  })
end

vim.keymap.set('n', '<Leader>ff', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "Files in git repo" })
vim.keymap.set('n', '<Leader>fr', builtin.oldfiles, { desc = "Recent files" })
vim.keymap.set('n', '<Leader>fw', builtin.live_grep, { desc = "Grep" })
vim.keymap.set('n', '<Leader>fb', builtin.buffers, { desc = "Buffers" })
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, { desc = "Help tags" })
vim.keymap.set('n', '<Leader>fd', open_dotfiles, { desc = "Dotfiles" })
vim.keymap.set('n', '<Leader>e', file_browser, { desc = "Open file browser" })
vim.keymap.set('n', '-', file_browser, { desc = "Open file browser" })
