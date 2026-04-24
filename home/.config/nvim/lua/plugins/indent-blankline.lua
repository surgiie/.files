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
			--- 1. Define highlight groups BEFORE running ibl
			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#474747" }) -- safe default
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#5eacd3" }) -- must exist!

			--- 2. Initial setup
			ibl.setup(opts)

			--- 3. Run ibl AFTER every colorscheme loads (not during preview)
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					-- ensure groups exist even if theme wipes them
					vim.api.nvim_set_hl(0, "IblIndent", { fg = "#474747" })
					vim.api.nvim_set_hl(0, "IblScope", { fg = "#5eacd3" })
					ibl.setup(opts)
				end,
			})

			--- 4. Disable ibl inside Snacks preview buffer (prevents early triggers)
			vim.api.nvim_create_autocmd("User", {
				pattern = "SnacksPickerPreview",
				callback = function(ev)
					vim.b[ev.buf].ibl_disable = true
				end,
			})
		end,
	},
}
