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
      },
    })

    onedark.load()
  end,
}
