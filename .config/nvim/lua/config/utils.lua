local U = {}

-- Changes diff symbols
U.diff_symbols = { added = ' ', modified = ' ', removed = ' ' }

-- Diagnositcs signs on the line number column and the status line
U.sings = { error = ' ', warn = ' ', info = ' ', hint = ' ' }

-- Common format-on-save for lsp servers that implements formatting
-- @param client table
-- @param buf integer
function U.fmt_on_save(client, buf)
  if client:supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('FORMATTING', { clear = true }),
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

return U
