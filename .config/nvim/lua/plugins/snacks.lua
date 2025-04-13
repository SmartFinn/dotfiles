-- A collection of QoL plugins for Neovim
-- https://github.com/folke/snacks.nvim

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    -- Open git log in vertical view
    {
      '<Leader>gl',
      function()
        Snacks.picker.git_log({
          finder = 'git_log',
          format = 'git_log',
          preview = 'git_show',
          confirm = 'git_checkout',
          layout = 'vertical',
        })
      end,
      desc = 'Git Log',
    },
    -- List git branches with Snacks_picker to quickly switch to a new branch
    {
      '<Leader>gb',
      function()
        Snacks.picker.git_branches({
          layout = 'select',
        })
      end,
      desc = 'Git Branches',
    },
    {
      '<Leader>fk',
      function()
        Snacks.picker.keymaps({
          layout = 'vertical',
        })
      end,
      desc = 'Keymaps',
    },
    -- Navigate my buffers
    {
      '<Leader>fb',
      function()
        Snacks.picker.buffers({
          -- I always want my buffers picker to start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
          finder = 'buffers',
          format = 'buffer',
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ['d'] = 'bufdelete',
              },
            },
            list = { keys = { ['d'] = 'bufdelete' } },
          },
        })
      end,
      desc = 'Find Buffers',
    },
    { '<Leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<Leader>fr', function() Snacks.picker.recent() end, desc = 'Recent Files' },
    { '<Leader>fw', function() Snacks.picker.grep_word() end,
      desc = 'Grep word under the cursor', mode = { 'n', 'x' } },
    { '<Leader>fg', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<Leader>fh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end,
      desc = 'Find Config File' },
    { '<leader>fd',
      function()
        Snacks.picker.git_files({
          args = {
            '--git-dir=' .. vim.fn.getenv('DOTBARE_DIR'),
            '--work-tree=' .. vim.fn.getenv('HOME')
          },
          cwd = vim.fn.getenv('HOME')
        })
      end,
      desc = 'Find Dotfiles' },
  },
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
    picker = { enabled = true },
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
