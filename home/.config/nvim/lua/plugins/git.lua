return {
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{ "<leader>gb", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	{
		-- Useful keymaps for handling git conflicts.
		"rhysd/conflict-marker.vim",
		config = function()
			vim.keymap.set(
				"n",
				"<leader>gct",
				"<Plug>(conflict-marker-themselves)",
				{ noremap = true, silent = true, desc = "Git Conflict: Choose Theirs" }
			)
			vim.keymap.set(
				"n",
				"<leader>gco",
				"<Plug>(conflict-marker-ourselves)",
				{ noremap = true, silent = true, desc = "Git Conflict: Choose Ours" }
			)
			vim.keymap.set(
				"n",
				"<leader>gcb",
				"<Plug>(conflict-marker-both)",
				{ noremap = true, silent = true, desc = "Git Conflict: Choose Both" }
			)
			vim.keymap.set(
				"n",
				"<leader>gcn",
				"<Plug>(conflict-marker-next-hunk)",
				{ noremap = true, silent = true, desc = "Git Conflict: Go To Next Conflict" }
			)
			vim.keymap.set(
				"n",
				"<leader>gcp",
				"<Plug>(conflict-marker-prev-hunk)",
				{ noremap = true, silent = true, desc = "Git Conflict: Go Previous Conflict" }
			)
		end,
	},
	{
		-- Puts git blame line highlight on current line
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
		opts = {
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end

				map("n", "gh", gs.next_hunk, "Next Hunk")
				map("n", "gH", gs.prev_hunk, "Prev Hunk")

				-- Actions
				map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>ghS", gs.undo_stage_hunk, "Undo stage hunk")

				map("v", "<leader>ghs", function() -- stage selected hunk
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage hunk")

				map("n", "<leader>gbs", gs.stage_buffer, "Stage buffer") -- stage whole buffer
				map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>gd", gs.diffthis, "Diff this")
			end,
		},
	},
}
