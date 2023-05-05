-- https://github.com/glepnir/dashboard-nvim

require("dashboard").setup({
	theme = 'doom',
	config = {
		header = {
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
			"",
		},
		center = {
			{
				icon = "  ",
				icon_hl = 'Title',
				desc = "Recently opened files    ",
				desc_hl = 'String',
				action = "Telescope oldfiles",
				key = 'r',
				keymap = "LEADER f",
				key_hl = 'Number',
			},
			{
				icon = "  ",
				icon_hl = 'Title',
				desc = "Find files",
				desc_hl = 'String',
				action = "Telescope find_files",
				key = 'f',
				keymap = "LEADER f",
				key_hl = 'Number',
			},
			{
				icon = "  ",
				icon_hl = 'Title',
				desc = "File browser",
				desc_hl = 'String',
				action = "Telescope file_browser",
				key = 'e',
				keymap = "LEADER  ",
				key_hl = 'Number',
			},
			{
				icon = "󰈞  ",
				icon_hl = 'Title',
				desc = "Find word",
				desc_hl = 'String',
				action = "Telescope live_grep",
				key = 'w',
				keymap = "LEADER f",
				key_hl = 'Number',
			},
			{
				icon = "  ",
				icon_hl = 'Title',
				desc = "Open dotfiles",
				desc_hl = 'String',
				action = "Telescope find_files find_command=dotbare,ls-files",
				key = 'd',
				keymap = "LEADER f",
				key_hl = 'Number',
			},
			{
				icon = "󰗼  ",
				icon_hl = 'Title',
				desc = "Quit",
				desc_hl = 'String',
				key = 'q',
				keymap = "        ",
				action = "quit",
				key_hl = 'Number',
			},
		},
	},
	preview = {
		file_height = 11,
		file_width = 70,
	},
})
