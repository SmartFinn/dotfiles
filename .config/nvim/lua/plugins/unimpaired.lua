-- A collection of useful keymaps
-- https://github.com/tummetott/unimpaired.nvim

return {
  'tummetott/unimpaired.nvim',
  event = 'VeryLazy',
  keys = {
    '[a', ']a', '[A', ']A',
    '[b', ']b', '[B', ']B',
    '[l', ']l', '[L', ']L',
    '[<C-l>', ']<C-l>',
    '[q', ']q', '[Q', ']Q',
    '[<C-q>', ']<C-q>',
    '[t', ']t', '[T', ']T',
    '[<C-t>', ']<C-t>',
    '[f', ']f',
    '[<Space>', ']<Space>',
    '[e', ']e',
    '[oc', ']oc', 'Zc',
    '[od', ']od', 'Zd',
    '[oh', ']oh', 'Zh',
    '[oi', ']oi', 'Zi',
    '[ol', ']ol', 'Zl',
    '[on', ']on', 'Zn',
    '[or', ']or', 'Zr',
    '[os', ']os', 'Zs',
    '[ob', ']ob', 'Zb',
    '[ot', ']ot', 'Zt',
    '[ou', ']ou', 'Zu',
    '[ov', ']ov', 'Zv',
    '[ow', ']ow', 'Zw',
    '[ox', ']ox', 'Zx',
  },
  opts = {
    -- Disable the default mappings if you prefer to define your own mappings
    default_keymaps = false,

    keymaps = {
      previous = {
        mapping = '[a',
        description = 'Jump to [count] previous file in arglist',
        dot_repeat = false
      },
      next = {
        mapping = ']a',
        description = 'Jump to [count] next file in arglist',
        dot_repeat = false,
      },
      first = {
        mapping = '[A',
        description = 'Jump to first file in arglist',
        dot_repeat = false,
      },
      last = {
        mapping = ']A',
        description = 'Jump to last file in arglist',
        dot_repeat = false,
      },
      bprevious = {
        mapping = '[b',
        description = 'Jump to [count] previous buffer',
        dot_repeat = false,
      },
      bnext = {
        mapping = ']b',
        description = 'Jump to [count] next buffer',
        dot_repeat = false,
      },
      bfirst = {
        mapping = '[B',
        description = 'Jump to first buffer',
        dot_repeat = false,
      },
      blast = {
        mapping = ']B',
        description = 'Jump to last buffer',
        dot_repeat = false,
      },
      lprevious = {
        mapping = '[l',
        description = 'Jump to [count] previous entry in loclist',
        dot_repeat = true,
      },
      lnext = {
        mapping = ']l',
        description = 'Jump to [count] next entry in loclist',
        dot_repeat = true,
      },
      lfirst = {
        mapping = '[L',
        description = 'Jump to first entry in loclist',
        dot_repeat = false,
      },
      llast = {
        mapping = ']L',
        description = 'Jump to last entry in loclist',
        dot_repeat = false,
      },
      lpfile = {
        mapping = '[<C-l>',
        description = 'Jump to last entry of [count] previous file in loclist',
        dot_repeat = true,
      },
      lnfile = {
        mapping = ']<C-l>',
        description = 'Jump to first entry of [count] next file in loclist',
        dot_repeat = true,
      },
      cprevious = {
        mapping = '[q',
        description = 'Jump to [count] previous entry in qflist',
        dot_repeat = true,
      },
      cnext = {
        mapping = ']q',
        description = 'Jump to [count] next entry in qflist',
        dot_repeat = true,
      },
      cfirst = {
        mapping = '[Q',
        description = 'Jump to first entry in qflist',
        dot_repeat = false,
      },
      clast = {
        mapping = ']Q',
        description = 'Jump to last entry in qflist',
        dot_repeat = false,
      },
      cpfile = {
        mapping = '[<C-q>',
        description = 'Jump to last entry of [count] previous file in qflist',
        dot_repeat = false,
      },
      cnfile = {
        mapping = ']<C-q>',
        description = 'Jump to first entry of [count] next file in qflist',
        dot_repeat = false,
      },
      tprevious = {
        mapping = '[t',
        description = 'Jump to [count] previous matching tag',
        dot_repeat = true,
      },
      tnext = {
        mapping = ']t',
        description = 'Jump to [count] next matching tag',
        dot_repeat = true,
      },
      tfirst = {
        mapping = '[T',
        description = 'Jump to first matching tag',
        dot_repeat = false,
      },
      tlast = {
        mapping = ']T',
        description = 'Jump to last matching tag',
        dot_repeat = false,
      },
      ptprevious = {
        mapping = '[<C-t>',
        description = ':tprevious in the preview window',
        dot_repeat = false,
      },
      ptnext = {
        mapping = ']<C-t>',
        description = ':tnext in the preview window',
        dot_repeat = false,
      },
      previous_file = {
        mapping = '[f',
        description = 'Previous file in directory. :colder in qflist',
        dot_repeat = false,
      },
      next_file = {
        mapping = ']f',
        description = 'Next file in directory. :cnewer in qflist',
        dot_repeat = false,
      },
      blank_above = {
        mapping = '[<Space>',
        description = 'Add [count] blank lines above',
        dot_repeat = true,
      },
      blank_below = {
        mapping = ']<Space>',
        description = 'Add [count] blank lines below',
        dot_repeat = true,
      },
      exchange_above = {
        mapping = '[e',
        description = 'Exchange line with [count] lines above',
        dot_repeat = true,
      },
      exchange_below = {
        mapping = ']e',
        description = 'Exchange line with [count] lines below',
        dot_repeat = true,
      },
      exchange_section_above = {
        mapping = '[e',
        description = 'Move section [count] lines up',
        dot_repeat = true,
      },
      exchange_section_below = {
        mapping = ']e',
        description = 'Move section [count] lines down',
        dot_repeat = true,
      },
      enable_cursorline = {
        mapping = '[oc',
        description = 'Enable cursorline',
        dot_repeat = false,
      },
      disable_cursorline = {
        mapping = ']oc',
        description = 'Disable cursorline',
        dot_repeat = false,
      },
      toggle_cursorline = {
        mapping = 'Zc',
        description = 'Toggle cursorline',
        dot_repeat = false,
      },
      enable_diff = {
        mapping = '[od',
        description = 'Enable diff',
        dot_repeat = false,
      },
      disable_diff = {
        mapping = ']od',
        description = 'Disable diff',
        dot_repeat = false,
      },
      toggle_diff = {
        mapping = 'Zd',
        description = 'Toggle diff',
        dot_repeat = false,
      },
      enable_hlsearch = {
        mapping = '[oh',
        description = 'Enable hlsearch',
        dot_repeat = false,
      },
      disable_hlsearch = {
        mapping = ']oh',
        description = 'Disable hlsearch',
        dot_repeat = false,
      },
      toggle_hlsearch = {
        mapping = 'Zh',
        description = 'Toggle hlsearch',
        dot_repeat = false,
      },
      enable_ignorecase = {
        mapping = '[oi',
        description = 'Enable ignorecase',
        dot_repeat = false,
      },
      disable_ignorecase = {
        mapping = ']oi',
        description = 'Disable ignorecase',
        dot_repeat = false,
      },
      toggle_ignorecase = {
        mapping = 'Zi',
        description = 'Toggle ignorecase',
        dot_repeat = false,
      },
      enable_list = {
        mapping = '[ol',
        description = 'Show invisible characters (listchars)',
        dot_repeat = false,
      },
      disable_list = {
        mapping = ']ol',
        description = 'Hide invisible characters (listchars)',
        dot_repeat = false,
      },
      toggle_list = {
        mapping = 'Zl',
        description = 'Toggle invisible characters (listchars)',
        dot_repeat = false,
      },
      enable_number = {
        mapping = '[on',
        description = 'Enable line numbers',
        dot_repeat = false,
      },
      disable_number = {
        mapping = ']on',
        description = 'Disable line numbers',
        dot_repeat = false,
      },
      toggle_number = {
        mapping = 'Zn',
        description = 'Toggle line numbers',
        dot_repeat = false,
      },
      enable_relativenumber = {
        mapping = '[or',
        description = 'Enable relative numbers',
        dot_repeat = false,
      },
      disable_relativenumber = {
        mapping = ']or',
        description = 'Disable relative numbers',
        dot_repeat = false,
      },
      toggle_relativenumber = {
        mapping = 'Zr',
        description = 'Toggle relative numbers',
        dot_repeat = false,
      },
      enable_spell = {
        mapping = '[os',
        description = 'Enable spell check',
        dot_repeat = false,
      },
      disable_spell = {
        mapping = ']os',
        description = 'Disable spell check',
        dot_repeat = false,
      },
      toggle_spell = {
        mapping = 'Zs',
        description = 'Toggle spell check',
        dot_repeat = false,
      },
      enable_background = {
        mapping = '[ob',
        description = 'Set background to light',
        dot_repeat = false,
      },
      disable_background = {
        mapping = ']ob',
        description = 'Set background to dark',
        dot_repeat = false,
      },
      toggle_background = {
        mapping = 'Zb',
        description = 'Toggle background',
        dot_repeat = false,
      },
      enable_colorcolumn = {
        mapping = '[ot',
        description = 'Enable colorcolumn',
        dot_repeat = false,
      },
      disable_colorcolumn = {
        mapping = ']ot',
        description = 'Disable colorcolumn',
        dot_repeat = false,
      },
      toggle_colorcolumn = {
        mapping = 'Zt',
        description = 'Toggle colorcolumn',
        dot_repeat = false,
      },
      enable_cursorcolumn = {
        mapping = '[ou',
        description = 'Enable cursorcolumn',
        dot_repeat = false,
      },
      disable_cursorcolumn = {
        mapping = ']ou',
        description = 'Disable cursorcolumn',
        dot_repeat = false,
      },
      toggle_cursorcolumn = {
        mapping = 'Zu',
        description = 'Toggle cursorcolumn',
        dot_repeat = false,
      },
      enable_virtualedit = {
        mapping = '[ov',
        description = 'Enable virtualedit',
        dot_repeat = false,
      },
      disable_virtualedit = {
        mapping = ']ov',
        description = 'Disable virtualedit',
        dot_repeat = false,
      },
      toggle_virtualedit = {
        mapping = 'Zv',
        description = 'Toggle virtualedit',
        dot_repeat = false,
      },
      enable_wrap = {
        mapping = '[ow',
        description = 'Enable line wrapping',
        dot_repeat = false,
      },
      disable_wrap = {
        mapping = ']ow',
        description = 'Disable line wrapping',
        dot_repeat = false,
      },
      toggle_wrap = {
        mapping = 'Zw',
        description = 'Toggle line wrapping',
        dot_repeat = false,
      },
      enable_cursorcross = {
        mapping = '[ox',
        description = 'Enable cursorcross',
        dot_repeat = false,
      },
      disable_cursorcross = {
        mapping = ']ox',
        description = 'Disable cursorcross',
        dot_repeat = false,
      },
      toggle_cursorcross = {
        mapping = 'Zx',
        description = 'Toggle cursorcross',
        dot_repeat = false,
      },
    }
  },
}
