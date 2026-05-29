return {
	"nvim-lualine/lualine.nvim",
	requires = "kyazdani42/nvim-web-devicons",
	config = function()
		local colors = {
			bg = nil,
			fg = "#e6e6e6",
			gray = "#6e6e6e",
			black = "#000001",
			green = "#a4e400",
			blue = "#62d8f1",
			yellow = "#ffff87",
			orange = "#ff9700",
			red = "#ff005f",
			purple = "#af87ff",
		}

		require("lualine").setup({
			options = {
				section_separators = "",
				component_separators = "│",
				globalstatus = true,
				theme = {
					normal = {
						a = { fg = colors.black, bg = colors.green, gui = "bold" },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.gray, bg = colors.bg },
					},
					insert = {
						a = { fg = colors.black, bg = colors.blue, gui = "bold" },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.gray, bg = colors.bg },
					},
					visual = {
						a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.gray, bg = colors.bg },
					},
					replace = {
						a = { fg = colors.black, bg = colors.red, gui = "bold" },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.gray, bg = colors.bg },
					},
					command = {
						a = { fg = colors.black, bg = colors.orange, gui = "bold" },
						b = { fg = colors.fg, bg = colors.bg },
						c = { fg = colors.gray, bg = colors.bg },
					},
					inactive = {
						a = { fg = colors.gray, bg = colors.bg, gui = "bold" },
						b = { fg = colors.gray, bg = colors.bg },
						c = { fg = colors.gray, bg = colors.bg },
					},
				},
			},
			tabline = {},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {
					"filetype",
					"diff",
					"branch",
					"location",
					"filesize",
				},
				lualine_z = { "mode" },
			},
		})
	end,
}
