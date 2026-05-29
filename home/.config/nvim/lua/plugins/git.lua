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
		"rhysd/conflict-marker.vim",
		config = function()
			local set = vim.keymap.set
			set(
				"n",
				"<leader>gct",
				"<Plug>(conflict-marker-themselves)",
				{ noremap = true, silent = true, desc = "Git Conflict: Choose Theirs" }
			)
			set(
				"n",
				"<leader>gco",
				"<Plug>(conflict-marker-ourselves)",
				{ noremap = true, silent = true, desc = "Git Conflict: Choose Ours" }
			)
			set(
				"n",
				"<leader>gcb",
				"<Plug>(conflict-marker-both)",
				{ noremap = true, silent = true, desc = "Git Conflict: Choose Both" }
			)
			set(
				"n",
				"<leader>gcn",
				"<Plug>(conflict-marker-next-hunk)",
				{ noremap = true, silent = true, desc = "Git Conflict: Go To Next Conflict" }
			)
			set(
				"n",
				"<leader>gcp",
				"<Plug>(conflict-marker-prev-hunk)",
				{ noremap = true, silent = true, desc = "Git Conflict: Go Previous Conflict" }
			)
		end,
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
