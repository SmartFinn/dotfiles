-- ChatGPT Neovim Plugin
-- https://github.com/jackmort/chatgpt.nvim

return {
  'jackmort/chatgpt.nvim',
  version = '*',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim'
  },
  event = 'VeryLazy',
  cmd = {
    'ChatGPT',
    'ChatGPTActAs',
    'ChatGPTRun',
    'ChatGPTEditWithInstructions',
  },
  opts = {
    api_key_cmd = "secret-tool lookup openai_api api_key",
  },
}
