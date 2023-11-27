-- Commenting
-- https://github.com/numToStr/Comment.nvim

return {
  'numToStr/Comment.nvim',
  version = 'v0.*',
  dependencies = {
    -- Neovim treesitter plugin for setting the commentstring based on
    -- the cursor location in a file
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = { enable_autocmd = false }
    },
  },
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = false,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = false,
    },
    pre_hook = function()
      local commentstring_avail, commentstring = pcall(
        require, "ts_context_commentstring.integrations.comment_nvim"
      )

      if commentstring_avail and commentstring then
        commentstring.create_pre_hook()
      end
    end,
  },
  keys = function()
    local comment_avail, comment = pcall(require, 'Comment.api')
    local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)

    if not comment_avail then
      return
    end

    -- Toggle current line (linewise) using C-/
    vim.keymap.set({'n', 'i'}, '<C-_>', comment.toggle.linewise.current, {
      desc = "Comment the current line",
    })

    -- mapping for kitty terminal
    vim.keymap.set({'n', 'i'}, '<C-/>', comment.toggle.linewise.current, {
      desc = "Comment the current line",
    })

    -- Toggle current line (blockwise) using C-\
    vim.keymap.set({'n', 'i'}, '<C-Bslash>', comment.toggle.blockwise.current, {
      desc = "Comment the current line (blockwise)",
    })

    -- Toggle selection (linewise)
    vim.keymap.set('x', '<C-_>', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      comment.toggle.linewise(vim.fn.visualmode())
    end, { desc = "Comment selected lines", })

    -- mapping for kitty terminal
    vim.keymap.set('x', '<C-/>', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      comment.toggle.linewise(vim.fn.visualmode())
    end, { desc = "Comment selected lines", })

    -- Toggle selection (blockwise)
    vim.keymap.set('x', '<C-Bslash>', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      comment.toggle.blockwise(vim.fn.visualmode())
    end, { desc = "Comment selected lines (blockwise)", })
  end,
}
