-- https://github.com/windwp/nvim-autopairs

require('nvim-autopairs').setup()

-- Integration w/ nvim-cmp
local status, cmp = pcall(require, 'cmp')
if status then
  cmp.event:on(
    'confirm_done',
    require('nvim-autopairs.completion.cmp').on_confirm_done()
  )
end
