-- :help lspconfig-all
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local lsp = require('lspconfig')
local U = require('user.plugins.lsp.utils')

-- Common perf related flags for all the LSP servers
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

-- Improve diagnositcs signs on the line number column
local signs = { Error = "󰅙 ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Common capabilities including lsp snippets and autocompletion
-- The nvim-cmp almost supports LSP's capabilities so You should
-- advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Common `on_attach` function for LSP servers
-- @param client table
-- @param buf integer
local function on_attach(client, buf)
  U.disable_formatting(client)
  U.mappings(buf)
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

-- Configuring native diagnostics
vim.diagnostic.config({
  virtual_text = {
    source = 'always',
  },
  float = {
    source = 'always',
  },
})

-- Lua
lsp.lua_ls.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        enable = true,
        showWord = 'Disable',
        -- keywordSnippet = 'Disable',
      },
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = { os.getenv('VIMRUNTIME') },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- List of the LSP server that don't need special configuration
local servers = {
  'ansiblels', -- Ansible
  'bashls', -- Bash
  'cssls', -- CSS
  'emmet_ls', -- emmet-ls
  'gopls', -- Golang
  'html', -- HTML
  'jsonls', -- Json
  'pyright', -- Python
  'tsserver', -- Typescript
  'yamlls', -- YAML
}

local conf = {
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
}

for _, server in ipairs(servers) do
  lsp[server].setup(conf)
end

-- NOTE: Using `eslint_d` via `null-ls` bcz it is way fasterrrrrrr.
-- Eslint
-- lsp.eslint.setup({
--   flags = flags,
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     useESLintClass = true, -- Recommended for eslint >= 7
--     run = 'onSave', -- Run `eslint` after save
--   },
--   -- NOTE: `root_dir` is required to fix the monorepo issue
--   root_dir = require('lspconfig.util').find_git_ancestor,
-- })
