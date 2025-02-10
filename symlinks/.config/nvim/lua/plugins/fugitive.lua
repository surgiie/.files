return {
	"tpope/vim-fugitive",
	lazy = false,
	dependencies = {
		"tpope/vim-rhubarb",
	},
	cmd = "G",
	config = function()
		vim.keymap.set("n", "<leader>gbl", ":G blame<CR>", { desc = "Show Git Blame Lines" })
	end,
}
