-- Indent guides
-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
  'lukas-reineke/indent-blankline.nvim',
  version = 'v2.*',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    buftype_exclude = {
      "nofile",
      "terminal",
    },
    filetype_exclude = {
      "help",
      "startify",
      "aerial",
      "alpha",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "neo-tree",
      "Trouble",
    },
    context_patterns = {
      "class",
      "return",
      "function",
      "method",
      "^if",
      "^while",
      "jsx_element",
      "^for",
      "^object",
      "^table",
      "block",
      "arguments",
      "if_statement",
      "else_clause",
      "jsx_element",
      "jsx_self_closing_element",
      "try_statement",
      "catch_clause",
      "import_statement",
      "operation_type",
    },
    show_trailing_blankline_indent = false,
    use_treesitter = false,
    char = "▏",
    context_char = "▏",
    show_current_context = true,
  },
  init = function()
    vim.api.nvim_create_autocmd({"Syntax"}, {
      desc = "Set custom highlighting for indent-blankline",
      group = vim.api.nvim_create_augroup("IndentBlacklineColors", { clear = true }),
      callback = function()
        vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#353c45', nocombine = true })
        vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#4f6687', nocombine = true })
        vim.api.nvim_set_hl(0, 'IndentBlanklineContextStart', { fg = '#4f6687', nocombine = true })
      end,
    })
  end,
}
