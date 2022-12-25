-- https://github.com/folke/which-key.nvim

local status, whichkey = pcall(require, 'which-key')
if not status then
  return
end

whichkey.setup()

vim.opt.timeoutlen = 500 -- reduce time of popup showing
