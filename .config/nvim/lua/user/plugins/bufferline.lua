-- https://github.com/akinsho/bufferline.nvim

require("bufferline").setup({
  options = {
    numbers = "ordinal",
    separator_style = "slant",
  }
})

for n = 1, 10, 1 do
  vim.keymap.set('', '<Leader>' .. n, '<CMD>BufferLineGoToBuffer' .. n .. '<CR>', {
    desc = "Go to buffer " .. n,
    silent = true,
  })
end

vim.keymap.set('', '<Leader>0', '<CMD>BufferLineGoToBuffer -1<CR>', {
  desc = "Go to the last buffer",
  silent = true,
})
