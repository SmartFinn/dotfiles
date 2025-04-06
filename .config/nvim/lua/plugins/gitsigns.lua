-- Gitsigns
-- https://github.com/lewis6991/gitsigns.nvim

return {
  'lewis6991/gitsigns.nvim',
  version = 'v0.*',
  event = { 'VeryLazy' },
  opts = {
    signs = {
      add          = { text = '│', },
      change       = { text = '│', },
      delete       = { text = '▂', },
      topdelete    = { text = '▔', },
      changedelete = { text = '├', },
      untracked    = { text = '┆', },
    },
    worktrees = {
      {
        toplevel = vim.env.HOME,
        gitdir = vim.env.HOME .. '/.local/var/dotbare',
      },
    },
    on_attach = function(buf)
      local map = vim.keymap.set
      local gs = package.loaded.gitsigns

      -- Navigation
      map('n', ']c', "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", {
        buffer = buf, expr = true, replace_keycodes = false,
        desc = "Git: Go to next hunk"
      })
      map('n', '[c', "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", {
        buffer = buf, expr = true, replace_keycodes = false,
        desc = "Git: Go to previous hunk"
      })

      -- Actions
      map({ 'n' }, '<leader>hl', gs.blame_line, {
        buffer = buf, desc = "Git: View Git blame"
      })
      map({ 'n' }, '<leader>hL',
        function() gs.blame_line({ full = true }) end, {
        buffer = buf, desc = "Git: View full Git blame"
      })
      map({ 'n', 'v' }, '<leader>hu', gs.undo_stage_hunk, {
        buffer = buf, desc = "Git: Undo the last stage"
      })
      map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, {
        buffer = buf, desc = "Git: unstage hunk"
      })
      map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, {
        buffer = buf, desc = "Git: stage hunk"
      })
      map('n', '<leader>hR', gs.reset_buffer, {
        buffer = buf, desc = "Git: unstage file"
      })
      map('n', '<leader>hS', gs.stage_buffer, {
        buffer = buf, desc = "Git: stage file"
      })
      map('n', '<leader>hp', gs.preview_hunk, {
        buffer = buf, desc = "Git: preview hunk"
      })
      map('n', '<leader>hd', gs.diffthis, {
        buffer = buf, desc = "Git: show diff"
      })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {
        buffer = buf, desc = "Git: select hunk"
      })
    end,
  },
}
