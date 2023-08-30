if vim.loader and vim.fn.has "nvim-0.9.1" == 1 then vim.loader.enable() end

-- Disable some of default plugins
local disabled_built_ins = {
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

require('config')
