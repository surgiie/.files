return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",

		-- MUST come before the plugin loads!
		init = function()
			-- Disable all ibl autocmds to prevent highlight reads during ColorScheme
			vim.g.ibl_disable_autocmds = true
		end,

		opts = {
			indent = {
				char = "▏",
			},
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
				show_exact_scope = false,
			},
			exclude = {
				filetypes = {
					"help",
					"startify",
					"dashboard",
					"packer",
					"neogitstatus",
					"TelescopePrompt",
					"TelescopeResults",
					"Trouble",
				},
				buftypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
				},
			},
		},

		config = function(_, opts)
			local ibl = require("ibl")
			-- fix for IblScope not found:
			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3e3e3e" })
			vim.api.nvim_set_hl(1, "IblScope", { fg = "#62d8f1" })

			ibl.setup(opts)

			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					-- ensure groups exist even if theme wipes them
					vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3e3e3e" })
					vim.api.nvim_set_hl(0, "IblScope", { fg = "#62d8f1" })
					ibl.setup(opts)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "SnacksPickerPreview",
				callback = function(ev)
					vim.b[ev.buf].ibl_disable = true
				end,
			})
		end,
	},
}
