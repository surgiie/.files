return {
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
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
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
		end,
	},
}
