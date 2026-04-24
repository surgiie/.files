return {
	"karb94/neoscroll.nvim",
	config = function()
		local neoscroll = require("neoscroll")
		neoscroll.setup({
			-- easing = 'sine',
		})
		local keymap = {
			["<C-d>"] = function()
				neoscroll.scroll(10, { duration = 100 })
			end,

			["<C-u>"] = function()
				neoscroll.scroll(-10, { duration = 100 })
			end,
			["<C-b>"] = function()
				neoscroll.scroll(-10, { duration = 100 })
			end,
			["<C-f>"] = function()
				neoscroll.scroll(10, { duration = 100 })
			end,
		}
		local modes = { "n", "v", "x" }
		for key, func in pairs(keymap) do
			vim.keymap.set(modes, key, func)
		end
	end,
}
