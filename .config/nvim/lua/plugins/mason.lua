-- Package Manager
-- https://github.com/williamboman/mason.nvim

return {
  'williamboman/mason.nvim',
  version = 'v1.*',
  event = 'VeryLazy',
  cmd = {
    'Mason',
    'MasonInstall',
    'MasonUninstall',
    'MasonUninstallAll',
    'MasonLog',
    'MasonUpdate',
    'MasonDebug',
  },
  build = ":MasonUpdate",
  opts = {
    ui = {
      border = 'rounded',
      width = 0.8,
      height = 0.8,
      icons = {
        package_installed = "",
        package_uninstalled = "",
        package_pending = "🟌",
      },
    },
  },
}
