require("core.options")
require("core.keymaps")
local handle = io.popen("uname -r")
if not handle then
	error("Error getting uname result")
else
	local result = handle:read("*a")
	handle:close()
	_G.IS_WSL = result:find("microsoft") ~= nil or result:find("WSL") ~= nil
end

-- Install lazy plugin manager if not already installed, this will let us use custom plugins.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not ((vim.uv or vim.loop)).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath);

-- Install custom plugins using lazy plugin manager.
(require("lazy")).setup({
	require("plugins.floatterm"),
	require("plugins.neotree"),
	require("plugins.theme"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.whichkey"),
	require("plugins.lsp"),
	require("plugins.autocompletion"),
	require("plugins.none-ls"),
	require("plugins.dashboard"),
	require("plugins.signs"),
	require("plugins.scrollview"),
	require("plugins.heritage"),
	require("plugins.copilot"),
	require("plugins.visual-multi"),
	require("plugins.commentary"),
	require("plugins.fugitive"),
	require("plugins.indent-blankline"),
	require("plugins.misc"),
	require("plugins.conflict"),
	require("plugins.refactoring"),
	require("plugins.noice"),
	require("plugins.trouble"),
})

