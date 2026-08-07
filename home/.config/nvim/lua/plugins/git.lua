return {
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{
				"<leader>bg",
				"<cmd>GitLink!<cr>",
				mode = { "n", "v" },
				desc = "Open current line or selection in GitHub",
			},
		},
	},
	{
		"akinsho/git-conflict.nvim",
		opts = {},
	},
	{
		"f-person/git-blame.nvim",
		lazy = false,
		config = function()
			vim.g.gitblame_highlight_group = "CursorLine"
			local git_blame = require("gitblame")

			require("lualine").setup({
				sections = {
					lualine_c = {
						{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
					},
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
