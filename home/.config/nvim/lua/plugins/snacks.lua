return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			styles = {
				input = {
					keys = {
						n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
						i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
					},
				},
			},
			-- Snacks Modules
			input = {
				enabled = true,
			},
			quickfile = {
				enabled = true,
				exclude = { "latex" },
			},
			-- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
			picker = {
				enabled = true,
				matchers = {
					frecency = true,
					cwd_bonus = false,
				},
				exclude = {
					".git",
					"node_modules",
					"dist",
					"build",
				},
				formatters = {
					file = {
						filename_first = true,
						filename_only = false,
						icon_width = 2,
					},
				},
				layout = {
					-- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
					-- override picker layout in keymaps function as a param below
					preset = "telescope", -- defaults to this layout unless overidden
					cycle = false,
				},
			},
		},
		-- NOTE: Keymaps
		keys = {
			{
				"<leader>rf",
				function()
					require("snacks").rename.rename_file()
				end,
				desc = "Fast Rename Current File",
			},
			{
				"<leader>vk",
				function()
					require("snacks").picker.keymaps({ layout = "ivy" })
				end,
				desc = "View Keymaps",
			},
			{
				"<leader>v:",
				function()
					require("snacks").picker.command_history()
				end,
				desc = "View Command History",
			},
			-- Git Stuff
			{
				"<leader>gs",
				function()
					require("snacks").picker.git_branches({ layout = "select" })
				end,
				desc = "Pick and Switch Git Branches",
			},
			-- Other Utils
			{
				"<leader>vt",
				function()
					require("snacks").picker.colorschemes({ layout = "ivy" })
				end,
				desc = "View Color Schemes",
			},
			{
				"<leader>vh",
				function()
					require("snacks").picker.help()
				end,
				desc = "View Help Pages",
			},
		},
	},
	-- NOTE: todo comments w/ snacks
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		optional = true,
		keys = {
			{
				"<leader>vtc",
				function()
					require("snacks").picker.todo_comments()
				end,
				desc = "View Todo Comments",
			},
		},
	},
}
