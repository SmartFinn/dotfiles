local map = vim.keymap.set

local U = {}

local fmt_group = vim.api.nvim_create_augroup('FORMATTING', { clear = true })

-- Common format-on-save for lsp servers that implements formatting
-- @param client table
-- @param buf integer
function U.fmt_on_save(client, buf)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = fmt_group,
      buffer = buf,
      callback = function()
        vim.lsp.buf.format({
          timeout_ms = 3000,
          buffer = buf,
        })
      end,
    })
  end
end

-- Disable formatting for servers | Handled by null-ls
-- @param client table
-- @see https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
function U.disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = true
end

-- Creates LSP mappings
-- @param buf number
function U.mappings(buf)
  local fmt = function(cmd) return function(str) return cmd:format(str) end end
  local lsp = fmt('<cmd>lua vim.lsp.%s<cr>')
  local diagnostic = fmt('<cmd>lua vim.diagnostic.%s<cr>')

  vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

  map('n', 'K', lsp 'buf.hover()', { buffer = buf, desc = "Hover symbol details" })
  map('n', 'gd', lsp 'buf.definition()', { buffer = buf, desc = "Show the definition of current symbol" })
  map('n', 'gD', lsp 'buf.declaration()', { buffer = buf, desc = "Declaration of current symbol" })
  map('n', 'gi', lsp 'buf.implementation()', { buffer = buf, desc = "Implementation of current symbol" })
  map('n', 'go', lsp 'buf.type_definition()', { buffer = buf, desc = "Definition of current type" })
  map('n', 'gr', lsp 'buf.references()', { buffer = buf, desc = "References of current symbol" })
  map('n', '<F2>', lsp 'buf.rename()', { buffer = buf, desc = "Rename current symbol" })
  map('n', '<F4>', lsp 'buf.code_action()', { buffer = buf, desc = "LSP code action" })
  map('x', '<F4>', lsp 'buf.range_code_action()', { buffer = buf, desc = "LSP code action" })
  map('n', '<C-k>', lsp 'buf.signature_help()', { buffer = buf, desc = "Signature help" })
  map('n', 'gl', diagnostic 'open_float()', { buffer = buf, desc = "Hover diagnostics" })
  map('n', '[d', diagnostic 'goto_prev()', { buffer = buf, desc = "Previous diagnostic" })
  map('n', ']d', diagnostic 'goto_next()', { buffer = buf, desc = "Next diagnostic" })
end

return U
