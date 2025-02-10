return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set("i", "<C-/>", 'copilot#Accept("<CR>")', {
			expr = true,
			silent = true,
			noremap = true,
			replace_keycodes = false,
		})
		-- handle windows inserting ^_ when pressing keybinding
		vim.keymap.set("i", "<C-_>", "copilot#Accept('<CR>')", { expr = true, silent = true, noremap = true, replace_keycodes = false })
		vim.g.copilot_no_tab_map = true
	end,
}
