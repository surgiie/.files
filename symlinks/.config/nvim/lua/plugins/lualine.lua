return {
	"nvim-lualine/lualine.nvim",
	requires = "kyazdani42/nvim-web-devicons",
	config = function()
		local separator = { '""', color = nil }
		local colors = {
			darkgray = "#16161d",
			gray = "#727169",
			innerbg = nil,
			outerbg = nil,
			normal = "#7e9cd8",
			insert = "#98bb6c",
			visual = "#ffa066",
			replace = "#e46876",
			command = "#e46876",
		}
		require("lualine").setup({
			options = {
				-- section_separators = '',
				-- component_separators = '',
				position = "top",
				globalstatus = true,
				theme = {
					inactive = {
						a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
						b = { fg = colors.gray, bg = colors.outerbg },
						c = { fg = colors.gray, bg = colors.innerbg },
					},
					visual = {
						a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
						b = { fg = colors.gray, bg = colors.outerbg },
						c = { fg = colors.gray, bg = colors.innerbg },
					},
					replace = {
						a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
						b = { fg = colors.gray, bg = colors.outerbg },
						c = { fg = colors.gray, bg = colors.innerbg },
					},
					normal = {
						a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
						b = { fg = colors.gray, bg = colors.outerbg },
						c = { fg = colors.gray, bg = colors.innerbg },
					},
					insert = {
						a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
						b = { fg = colors.gray, bg = colors.outerbg },
						c = { fg = colors.gray, bg = colors.innerbg },
					},
					command = {
						a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
						b = { fg = colors.gray, bg = colors.outerbg },
						c = { fg = colors.gray, bg = colors.innerbg },
					},
				},
			},
			sections = {
				lualine_a = {
					"mode",
					separator,
				},
				lualine_b = {
					"branch",
					"diff",
					separator,
					'"🖧  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
					{ "diagnostics", sources = { "nvim_diagnostic" } },
					separator,
				},
				lualine_c = {
					"filename",
				},
				lualine_x = {
					"filetype",
					"encoding",
					"fileformat",
				},
				lualine_y = {
					separator,
					'(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
					separator,
				},
				lualine_z = {
					"location",
					"progress",
				},
			},
		})
	end,
}
