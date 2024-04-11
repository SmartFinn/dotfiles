-- Notification manager
-- https://github.com/rcarriga/nvim-notify

return {
  'rcarriga/nvim-notify',
  version = 'v3.*',
  event = 'UIEnter',
  opts = {
    render = "compact",
    stages = "fade",
  }
}
