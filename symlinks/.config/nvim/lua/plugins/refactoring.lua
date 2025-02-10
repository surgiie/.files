return {
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({
				show_message = true,
			})
			vim.keymap.set("n", "<leader>rn", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, { expr = true })
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = false,
		config = function()
			-- load refactoring Telescope extension
			require("telescope").load_extension("refactoring")
			require("refactoring").setup()
			vim.keymap.set({ "n", "x" }, "<leader>r", function()
				require("telescope").extensions.refactoring.refactors()
			end)
		end,
	},
}
