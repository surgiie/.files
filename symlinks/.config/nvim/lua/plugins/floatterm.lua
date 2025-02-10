return {
	"voldikss/vim-floaterm",
	lazy = false,
	priority = 1000,
	config = function()
		vim.keymap.set("n", "<F1>", ":FloatermToggle scratch<CR>", { desc = "Open Terminal", silent = true })
		-- disable f1 so it doesnt open help.txt in insert mode and rebind the mapping to open our terminal
		vim.keymap.set(
			"i",
			"<F1>",
			'<Cmd>lua vim.cmd("FloatermToggle scratch")<CR>',
			{ noremap = true, desc = "Open Terminal", silent = true }
		)
		vim.keymap.set("t", "<F1>", "<C-\\><C-n>:FloatermToggle scratch<CR>", { desc = "Open Terminal", silent = true })
		vim.g.floaterm_gitcommit = "floaterm"
		vim.g.floaterm_autoinsert = 1
		vim.g.floaterm_wintype = "split"
		vim.g.floaterm_wintitle = 0
	end,
}
