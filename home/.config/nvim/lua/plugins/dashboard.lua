return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	requires = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dashboard = require("dashboard")

		local header = {
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣤⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⢀⣤⣾⡿⠟⠛⠉⠉⠉⠉⠛⠻⢿⣷⣤⡀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⣴⣿⠟⠁⠀⠀⢀⣀⣀⣀⣀⡀⠀⠀⠈⠛⠁⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⣾⡿⠁⠀⠀⣠⣾⡿⠟⠛⠛⠻⢿⡷⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⣸⣿⠃⠀⠀⣾⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⣿⣿⣶⣶⣾⣿⡇⠀⣴⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⠀⠀⠀",
			"⠀⠀⠀⠉⠉⠉⠉⠙⣿⣧⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⣿⡟⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣷⣄⡀⠀⠀⢀⣠⣄⠀⠀⠀⠀⣰⣿⠃⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⠿⠿⠿⠿⠟⠋⠁⠀⢀⣴⡿⠃⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠰⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⣀⣴⡿⠟⠁⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠿⢷⣶⣶⣶⣶⡾⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀",
			"",
			"",
			"",
		}

		local center = {
			{ icon = "            ", desc = "      Open A New File                       ", action = "enew" },
			{
				icon = "            ",
				shortcut = "SPC f",
				desc = "      Find A File                 ",
				action = "Telescope find_files",
			},
			{
				icon = "            ",
				shortcut = "SPC fb",
				desc = "      Show Recent Files              ",
				action = "Telescope oldfiles",
			},
			{
				icon = "            ",
				shortcut = "SPC g",
				desc = "      Search For Word                 ",
				action = "Telescope live_grep",
			},
		}
		local config = {
			header = header,
			center = center,
			footer = { "" },
		}
		dashboard.setup({
			theme = "doom",
			config = config,
		})

		local function pad(cfg)
			local height = vim.api.nvim_win_get_height(0)
			local mid = math.ceil(height / 2)
			local dbc = math.ceil((#cfg.center + #cfg.center - 1 + #cfg.header + #cfg.footer) / 2)
			for _ = 1, mid - dbc do
				table.insert(cfg.header, 1, "")
			end
		end

		pad(config)
	end,
}
