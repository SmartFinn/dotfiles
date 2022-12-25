-- https://github.com/Darazaki/indent-o-matic

local status, indent = pcall(require, 'indent-o-matic')
if not status then
  return
end

indent.setup({
  standard_widths = { 2, 4, 8 },
})
