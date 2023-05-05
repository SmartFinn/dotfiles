local cmp = require('cmp')
local luasnip = require('luasnip')

local icons = {
  Text = '󰉿',
  Method = '󰆧',
  Function = '󰊕',
  Constructor = '',
  Field = '󰜢',
  Variable = '󰀫',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '󰑭',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '󰈇',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '󰙅',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '',
}

local aliases = {
  nvim_lsp = 'lsp',
  luasnip = 'snippet',
}

vim.opt.completeopt:append('menu')
vim.opt.completeopt:append('menuone')
vim.opt.completeopt:append('noselect')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- confirm selection
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-y>'] = cmp.config.disable, -- remove the default `<C-y>` mapping

    -- scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-5), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(5), { 'i', 'c' }),

    -- toggle completion
    ['<C-Space>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end),

    -- when menu is visible, complete first or selected item on list
    -- when line is empty, insert a tab character
    -- when select mode, go to next placeholder in the snippet
    -- else, activate completion
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({select = true})
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- when menu is visible, complete first or select item on list
    -- when select mode, go to previous placeholder in the snippet
    -- else, revert to default behavior
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({select = true})
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),

  sources = cmp.config.sources({
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'nvim_lua', keyword_length = 1 },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'path' },
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, item)
      -- Kind icons
      item.kind = string.format('%s %s', icons[item.kind], item.kind)
      -- Source
      item.menu = string.format('[%s]', aliases[entry.source.name] or entry.source.name)
      return item
    end,
  },
})
