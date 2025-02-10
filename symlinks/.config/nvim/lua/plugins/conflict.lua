return {
	"rhysd/conflict-marker.vim",
	config = function()
		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>ct", "<Plug>(conflict-marker-themselves)", opts)
		vim.keymap.set("n", "<leader>co", "<Plug>(conflict-marker-ourselves)", opts)
		vim.keymap.set("n", "<leader>cb", "<Plug>(conflict-marker-both)", opts)
		vim.keymap.set("n", "<leader>cn", "<Plug>(conflict-marker-none)", opts)
		vim.keymap.set("n", "<leader>cx", "<Plug>(conflict-marker-next-hunk)", opts)
		vim.keymap.set("n", "<leader>cp", "<Plug>(conflict-marker-prev-hunk)", opts)
	end,
}
