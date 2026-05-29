return {
	"elentok/open-link.nvim",
	init = function()
		local expanders = require("open-link.expanders")
		require("open-link").setup({
			expanders = {
				expanders.github,
				expanders.url,
				function(text)
					if text:match("^https?://") or text:match("^[%w%-]+/[%w%-]+") then
						return nil
					end
					return "https://www.google.com/search?q=" .. vim.uri_encode(text)
				end,
			},
		})
	end,
	cmd = { "OpenLink" },
	keys = {
		{
			"<leader>b",
			"<cmd>OpenLink<cr>",
			desc = "Browse the link under the cursor in the default web browser",
			mode = "n",
		},
		{
			"<leader>b",
			function()
				vim.cmd('normal! "vy')
				local text = vim.fn.getreg("v")
				require("open-link.open")(text)
			end,
			desc = "Browse the selected text in the default web browser",
			mode = "v",
		},
	},
}
