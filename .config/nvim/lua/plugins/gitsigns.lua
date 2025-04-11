-- Gitsigns
-- https://github.com/lewis6991/gitsigns.nvim

return {
  'lewis6991/gitsigns.nvim',
  version = 'v1.*',
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
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          gs.nav_hunk('next')
        end
      end, {
          buffer = buf,
          replace_keycodes = false,
          desc = "Git: Go to next hunk",
        }
      )

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          gs.nav_hunk('prev')
        end
      end, {
          buffer = buf,
          replace_keycodes = false,
          desc = "Git: Go to previous hunk",
        }
      )

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
      map('n', '<leader>hr', gs.reset_hunk, {
        buffer = buf, desc = "Git: reset hunk"
      })
      map('n', '<leader>hs', gs.stage_hunk, {
        buffer = buf, desc = "Git: stage hunk"
      })
      map('v', '<leader>hs', function()
        gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, {
          buffer = buf,
          desc = "Git: stage selected hunk"
        }
      )
      map('v', '<leader>hr', function()
        gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, {
          buffer = buf,
          desc = "Git: unstage selected hunk"
        }
      )
      map('n', '<leader>hR', gs.reset_buffer, {
        buffer = buf, desc = "Git: reset file"
      })
      map('n', '<leader>hS', gs.stage_buffer, {
        buffer = buf, desc = "Git: stage file"
      })
      map('n', '<leader>hp', gs.preview_hunk, {
        buffer = buf, desc = "Git: preview hunk"
      })
      map('n', '<leader>hi', gs.preview_hunk_inline, {
        buffer = buf, desc = "Git: preview hunk inline"
      })
      map('n', '<leader>hd', gs.diffthis, {
        buffer = buf, desc = "Git: show diff"
      })

      -- Toggles
      map('n', '<leader>hB', gs.toggle_current_line_blame, {
        buffer = buf, desc = "Git: show git blame inline"
      })
      map('n', '<leader>hD', gs.toggle_deleted, {
        buffer = buf, desc = "Git: show deleted lines"
      })
      map('n', '<leader>hW', gs.toggle_word_diff, {
        buffer = buf, desc = "Git: show word diff"
      })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {
        buffer = buf, desc = "Git: select hunk"
      })
    end,
  },
}
