-- Notification manager
-- https://github.com/rcarriga/nvim-notify

return {
  'rcarriga/nvim-notify',
  version = 'v3.*',
  event = 'UIEnter',
  config = function()
    local notify = require("notify")

    notify.setup({
      stages = "fade",
    })

    vim.notify = notify
  end
}
