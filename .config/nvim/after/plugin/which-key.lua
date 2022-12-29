-- https://github.com/folke/which-key.nvim

local status, whichkey = pcall(require, 'which-key')
if not status then
  return
end

whichkey.setup({
  plugins = {
    spelling = { enabled = true },
    presets = { operators = false },
  },
  window = {
    border = "rounded",
    padding = { 2, 2, 2, 2 },
  },
  disable = { filetypes = { "TelescopePrompt" } },
})

vim.opt.timeoutlen = 500 -- reduce time of popup showing
