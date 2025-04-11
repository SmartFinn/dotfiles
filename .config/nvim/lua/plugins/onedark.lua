-- Colorscheme
-- https://github.com/navarasu/onedark.nvim

return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style = 'darker',
    transparent = false,
    lualine = {
      transparent = false,
    },
    highlights = {
      ['LineNr'] = {fg = '$bg3'},
      ['NormalFloat'] = {fg = '$fg', bg = '$bg0'},
      ['FloatBorder'] = {fg = '$grey', bg = '$bg0'},
    },
  },
  init = function()
    require('onedark').load()
  end
}
