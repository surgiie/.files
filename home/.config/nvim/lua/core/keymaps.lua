-- -- Helpers
-- -- -------------------------------------------------------------------------
--
-- --- Merge provided options with default keymap options
-- --- Default options: { noremap = true, silent = true }
-- --- @param args table|nil Optional table of keymap options to merge with defaults
-- --- @return table The merged options table
local function opts(args)
	local options = { noremap = true, silent = true }
	for key, value in pairs(args or {}) do
		options[key] = value
	end
	return options
end

local set = vim.keymap.set
-- -- -------------------------------------------------------------------------
-- -- Leader
-- -- -------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- -------------------------------------------------------------------------
-- Disabled Defaults
-- -- -------------------------------------------------------------------------
set({ "n" }, "<Space>", "<Nop>", opts({ desc = "Disable default space behaviour since its our leader" }))
set({ "v" }, "<Space>", "<Esc>", opts({ desc = "Cancel visual mode with space" }))
set("n", "q:", "<Nop>", opts({ desc = "Disable command history window" }))
set("n", "q/", "<Nop>", opts({ desc = "Disable search history window" }))
set("n", "q?", "<Nop>", opts({ desc = "Disable search history window" }))
set("n", "K", "<Nop>", opts({ desc = "Disable man/help lookup" }))
set({ "n", "i" }, "<F1>", "<Nop>", opts({ desc = "Disable help" }))
set({ "v", "i" }, "<C-C>", "<Esc>", opts({ desc = "Escape with ctrl-c." }))
-- -- -------------------------------------------------------------------------
-- -- Deletion (route all deletes/changes to black hole register)
-- -- -------------------------------------------------------------------------
set({ "n", "v" }, "d", '"_d', opts({ desc = "Delete without yanking" }))
set({ "n", "v" }, "D", '"_D', opts({ desc = "Delete to end of line without yanking" }))
set({ "n", "v" }, "de", '"_D', opts({ desc = "Delete to end of line without yanking" }))
set({ "n", "v" }, "c", '"_c', opts({ desc = "Change without yanking" }))
set({ "n", "v" }, "C", '"_C', opts({ desc = "Change to end of line without yanking" }))
set({ "n", "v" }, "x", '"_x', opts({ desc = "Delete character without yanking" }))
-- -------------------------------------------------------------------------
-- Yank
-- -------------------------------------------------------------------------
set("v", "y", "ygv", opts({ desc = "Yank and keep visual selection" }))
-- -------------------------------------------------------------------------
-- Undo / Redo
-- -------------------------------------------------------------------------
set("n", "<S-u>", "<C-r>", { remap = true, silent = true, desc = "Redo" })
-- -------------------------------------------------------------------------
-- Saving
-- -------------------------------------------------------------------------
set({ "n", "i" }, "<C-s>", "<cmd> w <CR><ESC>", opts({ desc = "Save buffer file" }))
-- -- -------------------------------------------------------------------------
-- -- Search
-- -- -------------------------------------------------------------------------
set("n", "n", "nzzzv", opts({ desc = "Go to next search result" }))
set("n", "<BS>", "<C-o>", opts({ desc = "Jump back in jumplist" }))
-- -- -------------------------------------------------------------------------
-- -- Cursor Navigation
-- -- -------------------------------------------------------------------------
set("n", "e", "$", opts({ desc = "Move cursor to end of line" }))
set("n", "s", "^", opts({ remap = true, desc = "Move cursor to start of line" }))
set("v", "s", "^", opts({ desc = "Move selection to start of line" }))
set("v", "e", "$", opts({ desc = "Move selection to end of line" }))
set("n", "vw", "viw", opts({ desc = "Select word under cursor" }))
set("n", "va", function()
	vim.cmd("normal! ggVG")
end, opts({ desc = "Select all text" }))
-- -- -------------------------------------------------------------------------
-- -- Word Navigation (insert mode)
-- -- -------------------------------------------------------------------------
set("i", "<C-b>", "<Esc>bi", opts({ desc = "Move backward by word in insert mode" }))
set("i", "<C-w>", "<Esc>wa", opts({ desc = "Move forward by word in insert mode" }))
set("i", "<C-S-a>", "<Esc>A", opts({ desc = "Move to end of line in insert mode" }))
-- -- -------------------------------------------------------------------------
-- -- Indentation
-- -- -------------------------------------------------------------------------
set("n", "<Tab>", ">>", opts({ desc = "Indent line" }))
set("n", "<S-Tab>", "<<", opts({ desc = "Unindent line" }))
set("v", "<Tab>", ">gv", opts({ desc = "Indent line" }))
set("v", "<S-Tab>", "<gv", opts({ desc = "Unindent line" }))
set("i", "<S-Tab>", "<C-\\><C-N><<<C-\\><C-N>^i", opts({ desc = "Unindent line" }))
set("n", "<", "<<", opts({ desc = "Unindent line" }))
set("n", ">", ">>", opts({ desc = "Indent line" }))
set("v", "<", "<gv", opts({ desc = "Unindent line" }))
set("v", ">", ">gv", opts({ desc = "Indent line" }))
-- -- -------------------------------------------------------------------------
-- -- Surround
-- -- -------------------------------------------------------------------------
-- --- Delete text inside paired delimiters under cursor and enter insert mode
-- --- Works with: (, [, {, ', ", `
-- set("n", "sdi", function()
-- 	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
-- 	local c = line:sub(col + 1, col + 1)
-- 	local map = {
-- 		["("] = "di(",
-- 		["["] = "di[",
-- 		["{"] = "di{",
-- 		["'"] = "di'",
-- 		['"'] = 'di"',
-- 		["`"] = "di`",
-- 	}
-- 	if map[c] then
-- 		vim.cmd("normal! " .. map[c])
-- 		vim.cmd("startinsert")
-- 	else
-- 		print("Unsupported character. Use one of: (, [, {, ', \", `")
-- 	end
-- end, opts({ desc = "Delete text inside paired delimiters and enter insert mode" }))
--
-- --- Delete surrounding delimiters while preserving inner text
-- --- Works with: (, [, {, ', ", `
-- set("n", "sd", function()
-- 	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
-- 	local c = line:sub(col + 1, col + 1)
-- 	local map = {
-- 		["("] = "di(hPl2x",
-- 		["["] = "di[hPl2x",
-- 		["{"] = "di{hPl2x",
-- 		["'"] = "di'hPl2x",
-- 		['"'] = 'di"hPl2x',
-- 		["`"] = "di`hPl2x",
-- 	}
-- 	if map[c] then
-- 		vim.cmd("normal! " .. map[c])
-- 		vim.api.nvim_win_set_cursor(0, { row, col })
-- 	else
-- 		print("Unsupported character. Use one of: (, [, {, ', \", `")
-- 	end
-- end, opts({ desc = "Delete surrounding delimiters" }))
--
-- --- Surround visual selection with paired delimiters
-- --- Usage: Select text in visual mode, press 'sw', then type the delimiter
-- set("v", "sw", function()
-- 	local cursor_pos = vim.api.nvim_win_get_cursor(0)
-- 	local start_pos = vim.fn.getpos("'<")
-- 	local cursor_offset = cursor_pos[2] - (start_pos[3] - 1)
--
-- 	vim.cmd('normal! "xy')
-- 	local selected_text = vim.fn.getreg("x")
--
-- 	local char = vim.fn.getchar()
-- 	char = type(char) == "number" and vim.fn.nr2char(char) or char
--
-- 	local surrounds = {
-- 		["("] = { "(", ")" },
-- 		[")"] = { "(", ")" },
-- 		["["] = { "[", "]" },
-- 		["]"] = { "[", "]" },
-- 		["{"] = { "{", "}" },
-- 		["}"] = { "{", "}" },
-- 		["<"] = { "<", ">" },
-- 		[">"] = { "<", ">" },
-- 		["'"] = { "'", "'" },
-- 		['"'] = { '"', '"' },
-- 		["`"] = { "`", "`" },
-- 	}
--
-- 	if surrounds[char] then
-- 		local left, right = surrounds[char][1], surrounds[char][2]
-- 		local new_text = left .. selected_text .. right
-- 		vim.cmd('normal! gv"_c' .. new_text)
-- 		vim.api.nvim_win_set_cursor(0, { cursor_pos[1], start_pos[3] - 1 + cursor_offset + 1 })
-- 	else
-- 		print("Unsupported character. Use one of: (, [, {, <, ', \", `")
-- 	end
-- end, opts({ desc = "Surround selection with delimiter" }))
--
--
-- -- -------------------------------------------------------------------------
-- -- Splits
-- -- -------------------------------------------------------------------------
-- set("n", "<leader>|", function()
-- 	vim.cmd("vsplit | enew")
-- end, opts({ desc = "Split vertically (new buffer)" }))
--
-- set("n", "<leader>-", function()
-- 	vim.cmd("split | enew")
-- end, opts({ desc = "Split horizontally (new buffer)" }))
--
-- set("n", "<leader>x", ":close<CR>", opts({ desc = "Close current split" }))
-- set("n", "<S-k>", ":resize +2<CR>", { silent = true, desc = "Increase split height" })
-- set("n", "<S-j>", ":resize -2<CR>", { silent = true, desc = "Decrease split height" })
-- set("n", "<S-h>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease split width" })
-- set("n", "<S-l>", ":vertical resize +2<CR>", { silent = true, desc = "Increase split width" })
--
-- -- -------------------------------------------------------------------------
-- Split / Buffer Navigation
-- -- -------------------------------------------------------------------------
--- Navigate to adjacent split or fallback to buffer navigation
--- @param dir string Direction: "h" (left), "l" (right), "j" (down), "k" (up)
local function navigate_buffer_or_split(dir)
	local before = vim.api.nvim_get_current_win()
	vim.cmd("silent! wincmd " .. dir)
	local after = vim.api.nvim_get_current_win()
	if after == before then
		pcall(function()
			local buf_cmd = (dir == "h") and "bprevious" or "bnext"
			vim.cmd(buf_cmd)
		end)
	end
end
set("n", "<leader>h", function()
	navigate_buffer_or_split("h")
end, vim.tbl_extend("force", {}, opts({ desc = "Left split or previous buffer" })))
set("n", "<leader>l", function()
	navigate_buffer_or_split("l")
end, vim.tbl_extend("force", {}, opts({ desc = "Right split or next buffer" })))
set("n", "<leader>j", "<C-w>j", opts({ desc = "Move to bottom split" }))
set("n", "<leader>k", "<C-w>k", opts({ desc = "Move to top split" }))
--
-- -- -------------------------------------------------------------------------
-- -- Buffers
-- -- -------------------------------------------------------------------------
set("n", "<leader>bn", "<cmd> enew <CR>", opts({ desc = "New buffer" }))
set("n", "<leader>b", "<cmd>BufferLinePick<CR>", opts({ desc = "Pick buffer from bufferline" }))
set("n", "<leader>bd", ":bdelete!<CR>", opts({ desc = "Delete buffer" }))
-- -------------------------------------------------------------------------
-- Comments
-- -------------------------------------------------------------------------
set({ "n", "v" }, "<leader>/", "gcc<Esc>", opts({ remap = true, silent = true, desc = "Toggle comment" }))
