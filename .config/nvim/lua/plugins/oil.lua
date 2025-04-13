-- Edit your filesystem like a buffer
-- https://github.com/stevearc/oil.nvim

return {
  'stevearc/oil.nvim',
  version = 'v2.*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'Oil',
  opts = {
    default_file_explorer = false,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      natural_order = true,
      is_always_hidden = function(name, _)
        return name == ".." or name == ".git"
      end,
    },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 0,
    },
    keymaps = {
      ["<C-c>"] = false,
      ["q"] = "actions.close",
    },
  },
}
