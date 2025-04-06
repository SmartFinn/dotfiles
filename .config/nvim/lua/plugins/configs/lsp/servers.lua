-- :help lspconfig-all
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local has_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not has_lspconfig then
  return
end

local U = require('plugins.configs.lsp.utils')

-- Diagnositcs
--------------

U.diagnostic_setup()

-- Servers
----------

-- Common perf related flags for all the LSP servers
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

-- Common capabilities including lsp snippets and autocompletion
-- The nvim-cmp almost supports LSP's capabilities so You should
-- advertise it to LSP servers..
local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  has_cmp and cmp_lsp.default_capabilities() or {}
)

-- Common `on_attach` function for LSP servers
-- @param client table
-- @param buf integer
local function on_attach(client, buf)
  U.disable_formatting(client)
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

local servers = {
  ansiblels = {},
  bashls = {},
  lua_ls = {
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
  pylsp = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
      },
    }
  },
  -- cssls = {},
  -- emmet_ls = {},
  -- html = {},
  -- jsonls = {},
  -- pyright = {},
  -- yamlls = {},
}

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      flags = flags,
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}
