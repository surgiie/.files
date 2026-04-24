return {
	-- Lazy
	{
		"polirritmico/monokai-nightasty.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			dark_style_background = "transparent",
			light_style_background = "transparent",
		},
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			transparent = true,
			style = "night",
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function()
			-- vim.cmd("colorscheme tokyonight")
		end,
	},
	{
		"marko-cerovac/material.nvim",
		config = function()
			require("material").setup({
				disable = {
					background = true,
				},
			})
			vim.g.material_style = "deep ocean"
			--vim.cmd("colorscheme material")
		end,
	},
}
