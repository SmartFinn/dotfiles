-- A collection of QoL plugins for Neovim
-- https://github.com/folke/snacks.nvim

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = {
      enabled = true,
      animate = {
        enabled = false,
      },
      indent = {
        char = "▏",
        only_scope = false, -- only show indent guides of the scope
        only_current = true, -- only show indent guides in the current window
      },
      chunk = {
        enabled = false,
        char = {
          corner_top = '┌',
          corner_bottom = '└',
          horizontal = '╌',
          vertical = '┊',
          arrow = '>',
        },
      },
      scope = {
        enabled = false, -- enable highlighting the current scope
        char = "▏",
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = 'SnacksIndentScope', ---@type string|string[] hl group for scopes
      },
    },
    input = { enabled = true },
    picker = { enabled = false },
    notifier = {
      enabled = true,
      timeout = 3500,
      style = 'fancy',
    },
    quickfile = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
}
