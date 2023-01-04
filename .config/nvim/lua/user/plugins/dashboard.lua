-- https://github.com/glepnir/dashboard-nvim

local dash = require("dashboard")

dash.default_banner = {
  "",
  "",
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
  "",
  " [ TIP: To exit Neovim, just power off your computer. ] ",
  "",
}

dash.preview_file_height = 11
dash.preview_file_width = 70
dash.custom_center = {
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = "Telescope oldfiles",
		shortcut = "LEADER f r",
	},
	{
		icon = "  ",
		desc = "Find files                              ",
		action = "Telescope find_files",
		shortcut = "LEADER f f",
	},
	{
		icon = "  ",
		desc = "File browser                            ",
		action = "Telescope file_browser",
		shortcut = "LEADER e  ",
	},
	{
		icon = "  ",
		desc = "Find word                               ",
		action = "Telescope live_grep",
		shortcut = "LEADER f w",
	},
	{
		icon = "  ",
		desc = "Open dotfiles                           ",
		action = "Telescope find_files find_command=dotbare,ls-files",
		shortcut = "LEADER f d"
	},
	{
		icon = "  ",
		desc = "Load lastest session                    ",
		shortcut = "LEADER s l",
		action = "SessionLoad",
	},
}
dash.session_directory = vim.fn.stdpath("data") .. "/session"

-- Autocmds
vim.api.nvim_create_autocmd({"FileType"}, {
  desc = "Quit dashboard by q key press",
  group = vim.api.nvim_create_augroup("dashboard", { clear = true }),
  pattern = { "dashboard" },
  callback = function()
    vim.keymap.set('n', 'q', '<CMD>quit<CR>', { buffer = true })
  end,
})
