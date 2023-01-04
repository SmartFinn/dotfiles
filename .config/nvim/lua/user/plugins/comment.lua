-- https://github.com/numToStr/Comment.nvim

require("Comment").setup({
  mappings = {
    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = false,
    ---Extra mapping; `gco`, `gcO`, `gcA`
    extra = false,
  },
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

local api = require('Comment.api')
local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)

-- Toggle current line (linewise) using C-/
vim.keymap.set({'n', 'i'}, '<C-_>', api.toggle.linewise.current, {
  desc = "Comment the current line",
})
-- mapping for kitty terminal
vim.keymap.set({'n', 'i'}, '<C-/>', api.toggle.linewise.current, {
  desc = "Comment the current line",
})

-- Toggle current line (blockwise) using C-\
vim.keymap.set({'n', 'i'}, '<C-Bslash>', api.toggle.blockwise.current, {
  desc = "Comment the current line (blockwise)",
})

-- Toggle selection (linewise)
vim.keymap.set('x', '<C-_>', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.linewise(vim.fn.visualmode())
end, { desc = "Comment selected lines", })

-- mapping for kitty terminal
vim.keymap.set('x', '<C-/>', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.linewise(vim.fn.visualmode())
end, { desc = "Comment selected lines", })

-- Toggle selection (blockwise)
vim.keymap.set('x', '<C-Bslash>', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.blockwise(vim.fn.visualmode())
end, { desc = "Comment selected lines (blockwise)", })
