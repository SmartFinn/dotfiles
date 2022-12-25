-- https://github.com/lukas-reineke/indent-blankline.nvim

local status, indent_blankline = pcall(require, 'indent_blankline')
if not status then
  return
end

local au_indent_blackline = vim.api.nvim_create_augroup("IndentBlacklineColors", { clear = true })
vim.api.nvim_create_autocmd({"VimEnter"}, {
  desc = "Set custom highlighting for indent-blankline",
  group = au_indent_blackline,
  callback = function()
    vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#353c45', nocombine = true })
    vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#4f6687', nocombine = true })
    vim.api.nvim_set_hl(0, 'IndentBlanklineContextStart', { fg = '#4f6687', nocombine = true })
  end,
})

indent_blankline.setup({
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
  use_treesitter = true,
  char = "▏",
  context_char = "▏",
  show_current_context = true,
})
