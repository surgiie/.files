return {
	"3rd/image.nvim",
	cond = vim.fn.has("win32") == 0 and vim.fn.has("wsl") == 0,
	build = false,
	opts = {
		backend = "ueberzug",
		processor = "magick_cli",
		integrations = {
			markdown = {
				enabled = false,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
				filetypes = { "markdown", "vimwiki" },
			},
		},
		max_height_window_percentage = 50,
	},
}
