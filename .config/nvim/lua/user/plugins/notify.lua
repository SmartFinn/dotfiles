-- https://github.com/rcarriga/nvim-notify

local notify = require("notify")

notify.setup({
  stages = "fade",
})

vim.notify = notify
