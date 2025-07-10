local au_vimrc = vim.api.nvim_create_augroup("vimrc", { clear = true })

vim.api.nvim_create_autocmd({"InsertEnter"}, {
  desc = "Show cursor line in insert mode",
  group = au_vimrc,
  pattern = "*",
  callback = function() vim.wo.cursorlineopt = "both" end,
})

vim.api.nvim_create_autocmd({"InsertLeave"}, {
  desc = "Hide cursor line when leaving insert mode",
  group = au_vimrc,
  pattern = "*",
  callback = function() vim.wo.cursorlineopt = "number" end,
})

vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
  desc = "Show colorcolumn in the current buffer",
  group = au_vimrc,
  pattern = "*",
  callback = function() vim.wo.colorcolumn = "+1" end,
})

vim.api.nvim_create_autocmd({"BufLeave", "WinLeave"}, {
  desc = "Hide colorcolumn when leaving the current buffer",
  group = au_vimrc,
  pattern = "*",
  callback = function() vim.wo.colorcolumn = "0" end,
})

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  desc = "Do not insert the current comment leader in a new line",
  group = au_vimrc,
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("o")
    vim.opt_local.formatoptions:remove("r")
  end,
})

vim.api.nvim_create_autocmd({"BufEnter"}, {
  desc = "Auto change directory",
  group = au_vimrc,
  pattern = "*",
  command = "silent! lcd %:p:h:gs/ /\\ /"
})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  desc = "Remove trailing whitespaces on save",
  group = au_vimrc,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

vim.api.nvim_create_autocmd({"BufReadPost"}, {
  desc = "Jump to the last edit position when opening files",
  group = au_vimrc,
  callback = function(data)
    -- https://github.com/numToStr/dotfiles/commit/49e6d6d
    local last_pos = vim.api.nvim_buf_get_mark(data.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(data.buf)
    if last_pos[1] > 0 and last_pos[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
    end
  end,
})

vim.api.nvim_create_autocmd({"VimResized"}, {
  desc = "Auto-resize splits when window is resized",
  group = au_vimrc,
  callback = function ()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Automatically creates parent directories for the current file if they
-- don't exist yet (auto_mkdir based)
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  desc = "Auto mkdir to a file",
  group = au_vimrc,
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 and not string.match(dir, '://') then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

vim.api.nvim_create_autocmd({"TextYankPost"}, {
  desc = "Highlight yanked text",
  group = au_vimrc,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
  end,
})

vim.api.nvim_create_augroup("quickfix", { clear = true })
vim.api.nvim_create_autocmd({"FileType"}, {
  desc = "Close quickfix window by q key press",
  group = "quickfix",
  pattern = { "qf", "netrw" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<CMD>close<CR>', {
      buffer = event.buf, silent = true
    })
  end,
})

vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = "UserLspConfig",
  callback = function(event)
    local lsp_client = vim.lsp.get_client_by_id(event.data.client_id)
    local lsp_methods = vim.lsp.protocol.Methods

    -- LSP specific options
    -----------------------

    -- Reserve space for diagnostic icons
    vim.opt_local.signcolumn = 'yes'

    -- Reduce time to spawn CursorHold event faster
    vim.opt_local.updatetime = 500

    -- Creates LSP mappings
    -----------------------

    for _, keymap in ipairs({
      { "n",          "gy",         vim.lsp.buf.type_definition,  "Goto type definition",            lsp_methods.textDocument_typeDefinition },
      { "n",          "gd",         vim.lsp.buf.definition,       "Goto definition",                 lsp_methods.textDocument_definition },
      { "n",          "gD",         vim.lsp.buf.declaration,      "Goto declaration",                lsp_methods.textDocument_declaration },
      { "n",          "gi",         vim.lsp.buf.implementation,   "Goto implementation",             lsp_methods.textDocument_implementation },
      { "n",          "gr",         vim.lsp.buf.references,       "Goto references",                 lsp_methods.textDocument_references },
      { "n",          "go",         vim.lsp.buf.type_definition,  "Definition of current type",      lsp_methods.textDocument_typeDefinition },
      { "n",          "<F2>",       vim.lsp.buf.rename,           "Rename symbol",                   lsp_methods.textDocument_rename },
      { { "n", "x" }, "<F4>",       vim.lsp.buf.code_action,      "Perform code action",             lsp_methods.textDocument_codeAction },
      { { "n", "i" }, "<C-k>",      vim.lsp.buf.signature_help,   "Show signature help",             lsp_methods.textDocument_signatureHelp },
      { "n",          "K",          vim.lsp.buf.hover,            "Show docs for item under cursor", lsp_methods.textDocument_hover },
      { "n",          "<Leader>s",  vim.lsp.buf.document_symbol,  "Open symbol picker",              lsp_methods.textDocument_documentSymbol },
      { "n",          "<Leader>S",  vim.lsp.buf.workspace_symbol, "Open workspace symbol picker",    lsp_methods.workspace_symbol },
      { "n",          "<Leader>F",  vim.lsp.buf.format,           "Auto-format a buffer",            lsp_methods.textDocument_formatting },
      { "v",          "<Leader>F",  vim.lsp.buf.format,           "Auto-format selected range",      lsp_methods.textDocument_rangeFormatting },
    }) do
      if lsp_client and lsp_client.supports_method(keymap[5]) then
        vim.keymap.set(keymap[1], keymap[2], keymap[3], { buffer = event.buf, desc = keymap[4] })
      end
    end

    if lsp_client and lsp_client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end

    if lsp_client and lsp_client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      vim.api.nvim_create_augroup("UserLspHighlightReferences", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "UserLspHighlightReferences",
        callback = vim.lsp.buf.document_highlight,
        buffer = event.buf,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = "UserLspHighlightReferences",
        callback = vim.lsp.buf.clear_references,
        buffer = event.buf,
      })
    end

    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, {
      buffer = event.buf, desc = "Add a folder to workspace"
    })
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, {
      buffer = event.buf, desc = "Remove a folder from workspace"
    })
    vim.keymap.set('n', '<Leader>wl', function()
      vim.notify("LSP workspaces: " .. vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = event.buf, desc = "List folders in the workspace" })

    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, {
      buffer = event.buf, desc = "Hover diagnostics"
    })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
      buffer = event.buf, desc = "Previous diagnostic"
    })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
      buffer = event.buf, desc = "Next diagnostic"
    })
    vim.keymap.set('n', '<Leader>d', vim.diagnostic.setloclist, {
      buffer = event.buf, desc = "Open diagnostic list"
    })
  end,
})
