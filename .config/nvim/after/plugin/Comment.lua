-- https://github.com/numToStr/Comment.nvim

local status, Comment = pcall(require, 'Comment')
if not status then
  return
end

Comment.setup({
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
vim.keymap.set({'n', 'i'}, '<C-_>', api.toggle.linewise.current)
-- mapping for kitty terminal
vim.keymap.set({'n', 'i'}, '<C-/>', api.toggle.linewise.current)

-- Toggle current line (blockwise) using C-\
vim.keymap.set({'n', 'i'}, '<C-\\>', api.toggle.blockwise.current)

-- Toggle selection (linewise)
vim.keymap.set('x', '<C-_>', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.linewise(vim.fn.visualmode())
end)
-- mapping for kitty terminal
vim.keymap.set('x', '<C-/>', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.linewise(vim.fn.visualmode())
end)

-- Toggle selection (blockwise)
vim.keymap.set('x', '<C-\\>', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.blockwise(vim.fn.visualmode())
end)
