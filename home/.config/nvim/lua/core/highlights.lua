-- -------------------------------------------------------------------------
-- Bufferline Colors
-- -------------------------------------------------------------------------
local bufferline_colors = {
	fill = "#212121",
	inactive_bg = "#2C2C2C",
	inactive_fg = "#616161",
	selected_bg = "#e2e2e2",
	selected_fg = "#212121",
	visible_bg = "#e2e2e2",
	visible_fg = "#212121",
	modified = "#212121",
}

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
		-- Snacks
		-- -------------------------------------------------------------------------
		hl(0, "SnacksPicker", { bg = "none", nocombine = true })
		hl(0, "SnacksPickerBorder", { fg = "#316c71", bg = "none", nocombine = true })

		-- -------------------------------------------------------------------------
		-- Neo-tree
		-- -------------------------------------------------------------------------
		hl(0, "NeoTreeCursorLine", { bg = "#1f2233" })
		hl(0, "NeoTreeNormal", { bg = "NONE" })
		hl(0, "NeoTreeNormalNC", { bg = "NONE" })
		hl(0, "NeoTreeFloatTitle", { bg = "NONE" })
		hl(0, "NeoTreeFloatBorder", { bg = "NONE" })

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
		-- Bufferline
		-- -------------------------------------------------------------------------
		hl(0, "BufferLineFill", { bg = bufferline_colors.fill })
		hl(0, "BufferLineSeparator", { bg = bufferline_colors.inactive_bg, fg = bufferline_colors.inactive_fg })
		hl(0, "BufferLineBackground", { bg = bufferline_colors.inactive_bg, fg = bufferline_colors.inactive_fg })
		hl(0, "BufferLineTab", { bg = bufferline_colors.inactive_bg, fg = bufferline_colors.inactive_fg })
		hl(0, "BufferLineTabSelected", { bg = bufferline_colors.selected_bg, fg = bufferline_colors.selected_fg })
		hl(0, "BufferLineDevIconDefault", { bg = bufferline_colors.inactive_bg, fg = bufferline_colors.inactive_fg })
		hl(
			0,
			"BufferLineDevIconDefaultSelected",
			{ bg = bufferline_colors.selected_bg, fg = bufferline_colors.selected_fg }
		)
		hl(
			0,
			"BufferLineDevIconDefaultInactive",
			{ bg = bufferline_colors.selected_bg, fg = bufferline_colors.selected_fg }
		)
		hl(0, "BufferLineBufferSelected", { bg = bufferline_colors.selected_bg, fg = bufferline_colors.selected_fg })
		hl(0, "BufferLineBufferVisible", { bg = bufferline_colors.visible_bg, fg = bufferline_colors.visible_fg })
		hl(0, "BufferLineModified", { bg = bufferline_colors.inactive_bg, fg = bufferline_colors.modified })
		hl(0, "BufferLineModifiedVisible", { bg = bufferline_colors.visible_bg, fg = bufferline_colors.modified })
		hl(0, "BufferLineModifiedSelected", { bg = bufferline_colors.selected_bg, fg = bufferline_colors.modified })
		hl(0, "BufferLineIndicatorSelected", { bg = bufferline_colors.selected_bg })
		hl(0, "BufferLineIndicatorVisible", { bg = bufferline_colors.visible_bg })
		hl(0, "BufferLineCloseButton", { bg = bufferline_colors.inactive_bg, fg = bufferline_colors.inactive_fg })
		hl(
			0,
			"BufferLineCloseButtonSelected",
			{ bg = bufferline_colors.selected_bg, fg = bufferline_colors.selected_fg }
		)
		hl(0, "BufferLineCloseButtonVisible", { bg = bufferline_colors.visible_bg, fg = bufferline_colors.visible_fg })

		-- -------------------------------------------------------------------------
		-- Bufferline Dev Icons (per filetype)
		-- -------------------------------------------------------------------------
		local files = {
			"Nix",
			"Http",
			"Php",
			"Html",
			"Lua",
			"Jpg",
			"NixOS",
			"Readme",
			"Yaml",
			"Lock",
			"Config",
			"Yml",
			"Zshrc",
			"Conf",
			"Json",
			"Toml",
			"GitCommit",
			"Hyprland",
			"GitConfig",
			"Mason",
			"License",
			"Bashrc",
			"Log",
			"Js",
			"PackageJson",
			"GitIgnore",
			"Git",
			"Go",
			"Py",
			"UI",
			"C",
			"CS",
			"Hypridle",
			"Hyprlock",
			"Hyprpaper",
			"Xml",
			"Sh",
			"Txt",
			"Css",
			"GitLogo",
			"GitHub",
			"Jsx",
			"Typescript",
			"Tsx",
			"Mk",
			"Makefile",
			"Terraform",
			"Vue",
			"Rust",
			"Dart",
			"Ini",
			"Jsonc",
			"Dockerfile",
			"Python",
		}
		for _, ft in ipairs(files) do
			local base = "BufferLineDevIcon" .. ft
			hl(0, base, { bg = bufferline_colors.inactive_bg, fg = bufferline_colors.inactive_fg })
			for _, suffix in ipairs({ "Selected", "Visible", "Inactive" }) do
				hl(0, base .. suffix, { bg = bufferline_colors.selected_bg, fg = bufferline_colors.selected_fg })
			end
		end
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
