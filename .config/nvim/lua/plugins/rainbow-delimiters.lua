-- Rainbow parentheses for neovim using tree-sitter
-- https://github.com/hiphish/rainbow-delimiters.nvim

return {
  'HiPhish/rainbow-delimiters.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  cond = vim.fn.has('nvim-0.9') == 1,
  lazy = false,
  init = function()
    vim.g.rainbow_delimiters = {
      highlight = {
        'RainbowDelimiterBlue',
        'RainbowDelimiterCyan',
        'RainbowDelimiterOrange',
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
      },
      blacklist = {'html', 'xml'},
    }
  end,
}
