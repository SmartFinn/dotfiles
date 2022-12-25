-- https://github.com/navarasu/onedark.nvim

local status, onedark = pcall(require, 'onedark')
if not status then
  return
end

onedark.setup({
  style = 'darker',
  transparent = false,
  lualine = {
    transparent = false,
  }
})

onedark.load()
