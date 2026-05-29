-- -------------------------------------------------------------------------
-- Core
-- -------------------------------------------------------------------------
require("functions")
require("core.keymaps")
require("core.options")
require("core.autocommands")

-- -------------------------------------------------------------------------
-- Lazy Bootstrap
-- -------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- -------------------------------------------------------------------------
-- Plugins
-- -------------------------------------------------------------------------
require("lazy").setup({
	{ import = "plugins" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	ui = {
		border = "rounded",
		pills = true,
		icons = {
			cmd = " ",
			config = "",
			event = "󰉁 ",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "󰒲 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			require = "󰢱 ",
			source = " ",
			start = " ",
			task = "✔ ",
			list = { "●", "➜", "★", "‒" },
		},
	},
})

-- -------------------------------------------------------------------------
-- Theme
-- -------------------------------------------------------------------------
require("current-theme")
