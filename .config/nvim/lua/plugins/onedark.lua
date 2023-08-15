-- Colorscheme
-- https://github.com/navarasu/onedark.nvim

return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = function ()
    local onedark = require("onedark")

    onedark.setup({
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
    })

    onedark.load()
  end,
}
