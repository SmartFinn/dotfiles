-- Bufferline
-- https://github.com/akinsho/bufferline.nvim

return {
  'akinsho/bufferline.nvim',
  version = 'v4.*',
  event = 'UIEnter',
  keys = function()
    for n = 1, 9, 1 do
      vim.keymap.set('', '<Leader>' .. n, '<CMD>BufferLineGoToBuffer' .. n .. '<CR>', {
        desc = "Go to buffer " .. n,
        silent = true,
      })
    end

    vim.keymap.set('', '<Leader>0', '<CMD>BufferLineGoToBuffer -1<CR>', {
      desc = "Go to the last buffer",
      silent = true,
    })
  end,
  opts = {
    options = {
      numbers = "ordinal",
      separator_style = "slant",
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
