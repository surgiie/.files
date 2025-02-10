return {
	"marko-cerovac/material.nvim",
	config = function()
		require("material").setup({
			-- ... other settings
			disable = {
				-- ... other settings
				background = true,
			},
		})
		vim.g.material_style = "deep ocean"

		vim.cmd("colorscheme material")
	end,
}
