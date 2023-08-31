-- Autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require("nvim-autopairs").setup({
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    })
    -- Integration w/ nvim-cmp
    local has_cmp, cmp = pcall(require, 'cmp')
    if has_cmp then
      cmp.event:on(
        'confirm_done',
        require('nvim-autopairs.completion.cmp').on_confirm_done()
      )
    end
  end,
}
