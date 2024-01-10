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
  desc = "Jump to the last place in the file before exiting",
  group = au_vimrc,
  callback = function(data)
    -- https://github.com/numToStr/dotfiles/commit/49e6d6d
    local last_pos = vim.api.nvim_buf_get_mark(data.buf, '"')
    if last_pos[1] > 0 and last_pos[1] <= vim.api.nvim_buf_line_count(data.buf) then
      vim.api.nvim_win_set_cursor(0, last_pos)
    end
  end,
})

-- Automatically creates parent directories for the current file if they
-- don't exist yet (auto_mkdir based)
vim.api.nvim_create_autocmd({"BufWritePre", "FileWritePre"}, {
  desc = "Auto mkdir to a file",
  group = au_vimrc,
  pattern = "*",
  callback = function()
    vim.cmd [[
      let b:dir = expand('<afile>:p:h')
      \ | if !isdirectory(b:dir) && !(b:dir =~ '://')
      \ |   call mkdir(iconv(b:dir, &encoding, &termencoding), 'p')
      \ | endif
  ]]
  end,
})

vim.api.nvim_create_autocmd({"TextYankPost"}, {
  desc = "Highlight yanked text",
  group = au_vimrc,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
  end,
})

vim.api.nvim_create_autocmd({"FileType"}, {
  desc = "Close quickfix window by q key press",
  group =  vim.api.nvim_create_augroup("quickfix", { clear = true }),
  pattern = { "qf", "netrw" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<CMD>close<CR>', {
      buffer = event.buf, silent = true
    })
  end,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(event)
    local bufnr = event.bufnr
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local au_lsp = vim.api.nvim_create_augroup("lsp_" .. client.name, { clear = true })

    -- LSP specific options
    -----------------------

    -- Reserve space for diagnostic icons
    vim.opt_local.signcolumn = 'yes'

    -- Reduce time to spawn CursorHold event faster
    vim.opt_local.updatetime = 500

    -- Show line diagnostics automatically in hover window
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = au_lsp,
      desc = "Show box with diagnosticis for current line",
      buffer = bufnr,
      callback = function() vim.diagnostic.open_float() end,
    })

    -- Creates LSP mappings
    -----------------------

    local map = vim.keymap.set
    local fmt = function(cmd) return function(str) return cmd:format(str) end end
    local lsp = fmt('<cmd>lua vim.lsp.buf.%s<cr>')
    local diagnostic = fmt('<cmd>lua vim.diagnostic.%s<cr>')

    if client.supports_method('textDocument/hover') then
      map('n', 'K', lsp 'hover()', { buffer = bufnr, desc = "Hover symbol details" })
    end

    if client.supports_method('textDocument/definition') then
      map('n', 'gd', lsp 'definition()', { buffer = bufnr, desc = "Show the definition of current symbol" })
    end

    if client.supports_method('textDocument/declaration') then
      map('n', 'gD', lsp 'declaration()', { buffer = bufnr, desc = "Declaration of current symbol" })
    end

    if client.supports_method('textDocument/implementation') then
      map('n', 'gi', lsp 'implementation()', { buffer = bufnr, desc = "Implementation of current symbol" })
    end

    if client.supports_method('textDocument/typeDefinition') then
      map('n', 'go', lsp 'type_definition()', { buffer = bufnr, desc = "Definition of current type" })
    end

    if client.supports_method('textDocument/references') then
      map('n', 'gr', lsp 'references()', { buffer = bufnr, desc = "References of current symbol" })
    end

    if client.supports_method('textDocument/signatureHelp') then
      map({'n', 'i'}, '<C-k>', lsp 'signature_help()', { buffer = bufnr, desc = "Signature help" })
    end

    if client.supports_method('textDocument/rename') then
      map('n', '<F2>', lsp 'rename()', { buffer = bufnr, desc = "Rename" })
    end

    if client.supports_method('textDocument/formatting') then
      map('n', '<leader>F', '<CMD>lua vim.lsp.buf.format({ async = true, force = true })<CR>', { buffer = bufnr, desc = "Format Range" })
    end

    if client.supports_method('textDocument/rangeFormatting') then
      map('v', '<leader>F', '<CMD>lua vim.lsp.buf.format({ async = false, force = true })<CR>', { buffer = bufnr, desc = "Format Range" })
    end

    if client.supports_method "textDocument/codeAction" then
      map('n', '<F4>', lsp 'code_action()', { buffer = bufnr, desc = "LSP code action" })
      map('x', '<F4>', lsp 'range_code_action()', { buffer = bufnr, desc = "LSP code action" })
    end

    map('n', '<Leader>wa', lsp 'add_workspace_folder()', { buffer = bufnr })
    map('n', '<Leader>wr', lsp 'remove_workspace_folder()', { buffer = bufnr })
    map('n', '<Leader>wl', function()
      vim.notify("LSP workspaces: " .. vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr })

    map('n', 'gl', diagnostic 'open_float()', { buffer = bufnr, desc = "Hover diagnostics" })
    map('n', '[d', diagnostic 'goto_prev()', { buffer = bufnr, desc = "Previous diagnostic" })
    map('n', ']d', diagnostic 'goto_next()', { buffer = bufnr, desc = "Next diagnostic" })
    map('n', '<Leader>d', diagnostic 'setloclist()', { buffer = bufnr, desc = "Open diagnostic list" })
  end,
})
