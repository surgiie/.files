-- -------------------------------------------------------------------------
-- Yank Highlight
-- -------------------------------------------------------------------------
vim.api.nvim_create_augroup("global", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- -------------------------------------------------------------------------
-- Trim Trailing Whitespace
-- -------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- -------------------------------------------------------------------------
-- Cursorline
-- -------------------------------------------------------------------------
vim.opt.cursorline = true

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	callback = function(event)
		vim.opt_local.cursorline = event.event == "InsertLeave"
	end,
})

vim.api.nvim_create_augroup("CustomBufWinEnter", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("CustomBufWinEnter", { clear = true }),
	callback = function()
		local ft = vim.bo.filetype
		local bt = vim.bo.buftype
		local win = vim.api.nvim_get_current_win()
		local cfg = vim.api.nvim_win_get_config(win)

		local is_float = cfg.relative ~= ""
		local is_neotree = ft == "neo-tree"
		local is_prompt = bt == "prompt" or ft == "neo-tree-popup"
		local is_filebuf = bt == "" and ft ~= ""

		if is_filebuf or is_neotree then
			vim.opt_local.cursorline = true
		else
			vim.opt_local.cursorline = false
		end

		if is_neotree or is_prompt then
			return
		end

		if is_float or is_filebuf then
			if vim.fn.exists(":Neotree") == 2 then
				pcall(vim.cmd, "Neotree close")
			end
		end
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = "CustomBufWinEnter",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "CustomBufWinEnter",
	pattern = { "TelescopePrompt", "cmp_menu" },
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
