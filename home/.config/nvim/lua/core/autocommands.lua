-- -------------------------------------------------------------------------
-- Bufferline Colors
-- -------------------------------------------------------------------------
local BUFFER_LINE_COLORS = {
	fill = "#212121",
	inactive_bg = "#212121",
	inactive_fg = "#616161",
	selected_bg = "#e2e2e2",
	selected_fg = "#212121",
	visible_bg = "#e2e2e2",
	visible_fg = "#212121",
	modified = "#212121",
}

-- -------------------------------------------------------------------------
-- Devicon Highlights
-- -------------------------------------------------------------------------
local function apply_devicon_highlights()
	local hl = vim.api.nvim_set_hl
	for _, name in ipairs(vim.fn.getcompletion("BufferLineDevIcon", "highlight")) do
		local is_active = name:match("Selected$") or name:match("Visible$") or name:match("Inactive$")
		if is_active then
			hl(0, name, { bg = BUFFER_LINE_COLORS.selected_bg, fg = BUFFER_LINE_COLORS.selected_fg })
		else
			hl(0, name, { bg = BUFFER_LINE_COLORS.inactive_bg, fg = BUFFER_LINE_COLORS.inactive_fg })
		end
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "BufAdd" }, {
	callback = function()
		vim.defer_fn(apply_devicon_highlights, 50)
	end,
})

-- -------------------------------------------------------------------------
-- ColorScheme Highlights
-- -------------------------------------------------------------------------
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local hl = vim.api.nvim_set_hl

		-- -------------------------------------------------------------------------
		-- Transparency
		-- -------------------------------------------------------------------------
		hl(0, "Scope", { bg = "NONE" })
		hl(0, "Normal", { bg = "NONE" })
		hl(0, "FloatBorder", { bg = "NONE" })
		hl(0, "ErrorMsg", { bg = "NONE" })
		hl(0, "NormalFloat", { bg = "NONE" })
		hl(0, "NormalNC", { bg = "NONE" })
		hl(0, "SignColumn", { bg = "NONE" })
		hl(0, "LineNr", { bg = "NONE" })
		hl(0, "Folded", { bg = "NONE" })
		hl(0, "FoldColumn", { bg = "NONE" })
		hl(0, "VertSplit", { bg = "NONE" })
		hl(0, "WinSeparator", { bg = "NONE" })
		hl(0, "EndOfBuffer", { bg = "NONE" })

		-- -------------------------------------------------------------------------
		-- Popup / Completion Menu
		-- -------------------------------------------------------------------------
		hl(0, "Pmenu", { bg = "NONE" })
		hl(0, "PmenuSbar", { bg = "NONE" })
		hl(0, "PmenuThumb", { bg = "NONE" })

		-- -------------------------------------------------------------------------
		-- UI Elements
		-- -------------------------------------------------------------------------
		hl(0, "CursorLine", { bg = "#131421" })
		hl(0, "Comment", { fg = "#ababab" })
		hl(0, "@comment", { link = "Comment" })
		hl(0, "Cursor", { bg = "#ababab" })
		hl(0, "StatusLine", { bg = nil })
		hl(0, "Visual", { bg = "#1f2233" })
		hl(0, "WinSeparator", { fg = "#1e1e1e", bg = "NONE" })

		-- -------------------------------------------------------------------------
		-- Trouble
		-- -------------------------------------------------------------------------
		hl(0, "TroubleNormal", { bg = "NONE" })
		hl(0, "TroubleNormalNC", { bg = "NONE" })
		hl(0, "TroubleText", { fg = "#e6e6e6" })
		hl(0, "TroubleCount", { fg = "#62d8f1", bg = "NONE" })
		hl(0, "TroubleIconError", { fg = "#ffffff" })
		hl(0, "TroubleIconWarning", { fg = "#ff9700" })
		hl(0, "TroubleIconHint", { fg = "#a4e400" })
		hl(0, "TroubleIconInfo", { fg = "#62d8f1" })
		-- -------------------------------------------------------------------------
		-- Noice
		-- -------------------------------------------------------------------------
		hl(0, "NoiceCmdlinePopupBorder", { fg = "#ffffff", bg = "NONE" })
		hl(0, "NoiceCmdlinePopupTitle", { fg = "#ffffff", bg = "NONE" })
		hl(0, "NoiceConfirmBorder", { fg = "#ffffff", bg = "NONE" })
		hl(0, "NoiceCmdlineIcon", { fg = "#ffffff", bg = "NONE" })
		-- -------------------------------------------------------------------------
		-- Snacks
		-- -------------------------------------------------------------------------
		hl(0, "SnacksPicker", { bg = "none", nocombine = true })
		hl(0, "SnacksPickerBorder", { fg = "#62d8f1", bg = "none", nocombine = true })

		-- -------------------------------------------------------------------------
		-- Neo-tree
		-- -------------------------------------------------------------------------
		hl(0, "NeoTreeCursorLine", { bg = "#1f2233" })
		hl(0, "NeoTreeNormal", { bg = "NONE" })
		hl(0, "NeoTreeNormalNC", { bg = "NONE" })
		hl(0, "NeoTreeFloatTitle", { bg = "NONE" })
		hl(0, "NeoTreeFloatBorder", { bg = "NONE" })
		hl(0, "NeoTreeWinSeparator", { fg = "NONE", bg = BUFFER_LINE_COLORS.inactive_bg })

		-- -------------------------------------------------------------------------
		-- Telescope
		-- -------------------------------------------------------------------------
		hl(0, "TelescopeNormal", { bg = "NONE" })
		hl(0, "Telescope", { bg = "NONE" })
		hl(0, "TelescopeBorder", { bg = "NONE" })
		hl(0, "TelescopePromptBorder", { bg = "NONE", fg = "NONE" })
		hl(0, "TelescopePromptTitle", { bg = "NONE", fg = "NONE" })

		-- -------------------------------------------------------------------------
		-- LSP Diagnostics
		-- -------------------------------------------------------------------------
		hl(0, "DiagnosticVirtualTextWarn", { fg = "#F2B91F", bg = "NONE" })
		hl(0, "DiagnosticVirtualTextHint", { bg = "NONE", fg = "#1FF25E" })
		hl(0, "DiagnosticVirtualTextOk", { bg = "NONE" })
		hl(0, "DiagnosticVirtualTextError", { bg = "NONE", fg = "#F21F3C" })
		hl(0, "DiagnosticVirtualTextInfo", { bg = "NONE", fg = "#1FC7F2" })
		-- -------------------------------------------------------------------------
		-- Lazy
		-- -------------------------------------------------------------------------
		hl(0, "LazyNormal", { bg = "NONE" })
		hl(0, "LazyH1", { bg = "#e2e2e2", fg = "#212121", bold = true })
		hl(0, "LazyButton", { bg = "#2a2a2a", fg = "#9a9a9a" })
		hl(0, "LazyButtonActive", { bg = "#e2e2e2", fg = "#212121", bold = true })
		hl(0, "LazyH2", { fg = "#e2e2e2", bold = true })
		hl(0, "LazySpecial", { fg = "#e2e2e2" })
		-- -------------------------------------------------------------------------
		-- Dashboard
		-- -------------------------------------------------------------------------
		hl(0, "DashboardHeader", { fg = "#ffffff" })
		hl(0, "DashboardCenter", { fg = "#f8f8f2" })
		hl(0, "DashboardShortcut", { fg = "#bd93f9" })
		hl(0, "DashboardFooter", { fg = "#ffffff" })
		-- -------------------------------------------------------------------------
		-- Bufferline
		-- -------------------------------------------------------------------------
		hl(0, "BufferLineFill", { bg = "NONE" })
		hl(0, "BufferLineOffsetSeparator", { fg = BUFFER_LINE_COLORS.inactive_bg, bg = BUFFER_LINE_COLORS.inactive_bg })
		hl(0, "TabLineFill", { bg = BUFFER_LINE_COLORS.fill })
		hl(0, "BufferLineSeparator", { bg = BUFFER_LINE_COLORS.inactive_bg, fg = BUFFER_LINE_COLORS.inactive_fg })
		hl(0, "BufferLineBackground", { bg = BUFFER_LINE_COLORS.inactive_bg, fg = BUFFER_LINE_COLORS.inactive_fg })
		hl(0, "BufferLineTab", { bg = BUFFER_LINE_COLORS.inactive_bg, fg = BUFFER_LINE_COLORS.inactive_fg })
		hl(0, "BufferLineTabSelected", { bg = BUFFER_LINE_COLORS.selected_bg, fg = BUFFER_LINE_COLORS.selected_fg })
		hl(0, "BufferLineDevIconDefault", { bg = BUFFER_LINE_COLORS.inactive_bg, fg = BUFFER_LINE_COLORS.inactive_fg })
		hl(
			0,
			"BufferLineDevIconDefaultSelected",
			{ bg = BUFFER_LINE_COLORS.selected_bg, fg = BUFFER_LINE_COLORS.selected_fg }
		)
		hl(
			0,
			"BufferLineDevIconDefaultInactive",
			{ bg = BUFFER_LINE_COLORS.selected_bg, fg = BUFFER_LINE_COLORS.selected_fg }
		)
		hl(0, "BufferLineBufferSelected", { bg = BUFFER_LINE_COLORS.selected_bg, fg = BUFFER_LINE_COLORS.selected_fg })
		hl(0, "BufferLineBufferVisible", { bg = BUFFER_LINE_COLORS.visible_bg, fg = BUFFER_LINE_COLORS.visible_fg })
		hl(0, "BufferLineModified", { bg = BUFFER_LINE_COLORS.inactive_bg, fg = BUFFER_LINE_COLORS.modified })
		hl(0, "BufferLineModifiedVisible", { bg = BUFFER_LINE_COLORS.visible_bg, fg = BUFFER_LINE_COLORS.modified })
		hl(0, "BufferLineModifiedSelected", { bg = BUFFER_LINE_COLORS.selected_bg, fg = BUFFER_LINE_COLORS.modified })
		hl(0, "BufferLineIndicatorSelected", { bg = BUFFER_LINE_COLORS.selected_bg })
		hl(0, "BufferLineIndicatorVisible", { bg = BUFFER_LINE_COLORS.visible_bg })
		hl(0, "BufferLineCloseButton", { bg = BUFFER_LINE_COLORS.inactive_bg, fg = BUFFER_LINE_COLORS.inactive_fg })
		hl(
			0,
			"BufferLineCloseButtonSelected",
			{ bg = BUFFER_LINE_COLORS.selected_bg, fg = BUFFER_LINE_COLORS.selected_fg }
		)
		hl(
			0,
			"BufferLineCloseButtonVisible",
			{ bg = BUFFER_LINE_COLORS.visible_bg, fg = BUFFER_LINE_COLORS.visible_fg }
		)

		vim.defer_fn(apply_devicon_highlights, 100)
	end,
})

-- -------------------------------------------------------------------------
-- Markdown Highlights
-- -------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.schedule(function()
			local hl = vim.api.nvim_set_hl
			hl(0, "RenderMarkdownCode", { bg = "none" })
			hl(0, "RenderMarkdownH1Bg", { bg = "none" })
			hl(0, "RenderMarkdownH2Bg", { bg = "none" })
			hl(0, "RenderMarkdownH3Bg", { bg = "none" })
			hl(0, "RenderMarkdownH4Bg", { bg = "none" })
			hl(0, "RenderMarkdownH5Bg", { bg = "none" })
			hl(0, "RenderMarkdownH6Bg", { bg = "none" })
		end)
	end,
})

-- -------------------------------------------------------------------------
-- Yank Highlight
-- -------------------------------------------------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- -------------------------------------------------------------------------
-- Tiltfile Filetype Detection
-- -------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "Tiltfile", "*.tilt", "*.Tiltfile", "*.tiltfile" },
	callback = function()
		vim.bo.filetype = "starlark"
	end,
})

-- -------------------------------------------------------------------------
-- Shebang Filetype Detection
-- -------------------------------------------------------------------------
local SHEBANG_FILETYPES = {
	bash = "sh",
	zsh = "zsh",
	php = "php",
	python = "python",
	python3 = "python",
}

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*",
	callback = function()
		if vim.bo.filetype ~= "" then
			return
		end
		local line = vim.fn.getline(1)
		local shebang = line:match("^#!.*/(%S+)$") or line:match("^#!.*/(%S+)%s")
		if shebang then
			local ft = SHEBANG_FILETYPES[shebang]
			if ft then
				vim.bo.filetype = ft
			end
		end
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
local custom_group = vim.api.nvim_create_augroup("CustomBufWinEnter", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	group = custom_group,
	callback = function(event)
		vim.opt_local.cursorline = event.event == "InsertLeave"
	end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = custom_group,
	callback = function()
		local ft = vim.bo.filetype
		local bt = vim.bo.buftype
		local win = vim.api.nvim_get_current_win()
		local cfg = vim.api.nvim_win_get_config(win)

		local is_float = cfg.relative ~= ""
		local is_neotree = ft == "neo-tree"
		local is_prompt = bt == "prompt" or ft == "neo-tree-popup"
		local is_filebuf = bt == "" and ft ~= "" and not is_float

		if is_filebuf or is_neotree then
			vim.opt_local.cursorline = true
		else
			vim.opt_local.cursorline = false
		end

		if is_neotree or is_prompt or is_float then
			return
		end

		if is_filebuf and vim.fn.exists(":Neotree") == 2 then
			pcall(vim.cmd, "Neotree close")
		end
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = custom_group,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = custom_group,
	pattern = { "TelescopePrompt", "cmp_menu" },
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- -------------------------------------------------------------------------
-- Autosave on Insert Leave
-- -------------------------------------------------------------------------
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		local bt = vim.bo.buftype
		local ft = vim.bo.filetype
		if bt == "" and ft ~= "" and vim.bo.modifiable and not vim.bo.readonly then
			vim.cmd("silent! w")
		end
	end,
})

-- -------------------------------------------------------------------------
-- Neo-tree Win Separator
-- -------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	group = custom_group,
	callback = function()
		if vim.bo.filetype == "neo-tree" then
			vim.opt_local.fillchars:append({ vert = " " })
		end
	end,
})
