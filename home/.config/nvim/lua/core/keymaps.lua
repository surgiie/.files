-- -------------------------------------------------------------------------
-- Helpers
-- -------------------------------------------------------------------------

--- Merge provided options with default keymap options
--- Default options: { noremap = true, silent = true }
--- @param args table|nil Optional table of keymap options to merge with defaults
--- @return table The merged options table
local function opts(args)
	local options = { noremap = true, silent = true }
	for key, value in pairs(args or {}) do
		options[key] = value
	end
	return options
end

local set = vim.keymap.set

-- -------------------------------------------------------------------------
-- Leader
-- -------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- -------------------------------------------------------------------------
-- Disabled Defaults
-- -------------------------------------------------------------------------
set({ "n", "v" }, "<Space>", "<Nop>", opts({ desc = "Disable default space behaviour since its our leader" }))

-- -------------------------------------------------------------------------
-- Deletion (no yank)
-- -------------------------------------------------------------------------
set("n", "x", '"_x', opts({ desc = "Delete character under cursor without yanking" }))
set("n", "X", '"_X', opts({ desc = "Delete character before cursor without yanking" }))
set("n", "dd", '"_dd', opts({ desc = "Delete current line without yanking" }))
set("n", "dw", '"_dw', opts({ desc = "Delete word after cursor without yanking" }))
set("n", "db", '"_db', opts({ desc = "Delete word before cursor without yanking" }))
set("n", "d$", '"_d$', opts({ desc = "Delete to end of line without yanking" }))
set("n", "d^", '"_d^', opts({ desc = "Delete to start of line without yanking" }))
set("n", "d0", '"_d0', opts({ desc = "Delete to beginning of line without yanking" }))
set("n", "dG", '"_dG', opts({ desc = "Delete to end of file without yanking" }))
set("n", "dgg", '"_dgg', opts({ desc = "Delete to start of file without yanking" }))
set("n", "dp", '"_dp', opts({ desc = "Delete paste buffer without yanking" }))
set("x", "d", '"_d', opts({ desc = "Delete selection without yanking" }))
set("x", "x", '"_x', opts({ desc = "Delete selection without yanking" }))
set("n", "ds", '"_d^', opts({ desc = "Delete to start of line without yanking" }))
set("n", "de", '"_d$', opts({ desc = "Delete to end of line without yanking" }))
set("n", "xe", "d$", opts({ desc = "Delete to end of line" }))
set("n", "Xs", "d^", opts({ desc = "Delete to start of line" }))

-- -------------------------------------------------------------------------
-- Yank
-- -------------------------------------------------------------------------
set("v", "y", "myy`ygv", opts({ desc = "Yank and keep selection" }))
set("v", "Y", "myY`Ygv", opts({ desc = "Yank line and keep selection" }))

-- -------------------------------------------------------------------------
-- Undo / Redo
-- -------------------------------------------------------------------------
set("n", "<S-u>", "<C-r>", { remap = true, silent = true, desc = "Redo" })

-- -------------------------------------------------------------------------
-- Saving
-- -------------------------------------------------------------------------
set("n", "<C-s>", "<cmd> w <CR><ESC>", opts({ desc = "Save buffer file" }))
set("i", "<C-s>", "<Esc>:w<CR>", opts({ desc = "Save buffer file and return to normal mode" }))

-- -------------------------------------------------------------------------
-- Search
-- -------------------------------------------------------------------------
set("n", "<Esc>", ":noh<CR>", opts({ desc = "Clear highlights on escape" }))
set("n", "<C-c>", ":nohl<CR>", opts({ desc = "Clear search highlight" }))
set("n", "n", "nzzzv", opts({ desc = "Go to next search result" }))
set("n", "N", "Nzzzv", opts({ desc = "Go to previous search result" }))

-- -------------------------------------------------------------------------
-- Cursor Navigation
-- -------------------------------------------------------------------------
set("n", "<C-d>", "<C-d>zz", opts({ desc = "Move down in buffer with cursor centered" }))
set("n", "<C-u>", "<C-u>zz", opts({ desc = "Move up in buffer with cursor centered" }))
set("n", "e", "$", opts({ desc = "Move cursor to end of line" }))
set("n", "s", "^", opts({ remap = true, desc = "Move cursor to start of line" }))
set("v", "s", "^", opts({ desc = "Move selection to start of line" }))
set("v", "e", "$", opts({ desc = "Move selection to end of line" }))
set("n", "vw", "viw", opts({ desc = "Select word" }))
set("n", "<C-a>", function()
	vim.cmd("normal! ggVG")
end, opts({ desc = "Select all text" }))
set("n", "<S-Space>", "X", opts({ remap = true, desc = "Backspace" }))
set("i", "<S-Space>", "<Backspace>", opts({ desc = "Backspace" }))

-- -------------------------------------------------------------------------
-- Word Navigation (insert mode)
-- -------------------------------------------------------------------------
set("i", "<C-b>", "<Esc>bi", opts({ desc = "Move backward by word in insert mode" }))
set("i", "<C-w>", "<Esc>wa", opts({ desc = "Move forward by word in insert mode" }))

-- -------------------------------------------------------------------------
-- Indentation
-- -------------------------------------------------------------------------
set("n", "<Tab>", ">>", opts({ desc = "Indent line" }))
set("n", "<S-Tab>", "<<", opts({ desc = "Unindent line" }))
set("v", "<Tab>", ">gv", opts({ desc = "Indent line" }))
set("v", "<S-Tab>", "<gv", opts({ desc = "Unindent line" }))
set("i", "<S-Tab>", "<C-\\><C-N><<<C-\\><C-N>^i", opts({ desc = "Unindent line" }))
set("v", "<", "<gv", opts({ desc = "Indent line and stay in indent mode" }))
set("v", ">", ">gv", opts({ desc = "Unindent line and stay in indent mode" }))

-- -------------------------------------------------------------------------
-- Surround
-- -------------------------------------------------------------------------

--- Delete text inside paired delimiters under cursor and enter insert mode
--- Works with: (, [, {, ', ", `
set("n", "sdi", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
	local c = line:sub(col + 1, col + 1)
	local map = {
		["("] = "di(",
		["["] = "di[",
		["{"] = "di{",
		["'"] = "di'",
		['"'] = 'di"',
		["`"] = "di`",
	}
	if map[c] then
		vim.cmd("normal! " .. map[c])
		vim.cmd("startinsert")
	else
		print("Unsupported character. Use one of: (, [, {, ', \", `")
	end
end, opts({ desc = "Delete text inside paired delimiters and enter insert mode" }))

--- Delete surrounding delimiters while preserving inner text
--- Works with: (, [, {, ', ", `
set("n", "sd", function()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
	local c = line:sub(col + 1, col + 1)
	local map = {
		["("] = "di(hPl2x",
		["["] = "di[hPl2x",
		["{"] = "di{hPl2x",
		["'"] = "di'hPl2x",
		['"'] = 'di"hPl2x',
		["`"] = "di`hPl2x",
	}
	if map[c] then
		vim.cmd("normal! " .. map[c])
		vim.api.nvim_win_set_cursor(0, { row, col })
	else
		print("Unsupported character. Use one of: (, [, {, ', \", `")
	end
end, opts({ desc = "Delete surrounding delimiters" }))

--- Surround visual selection with paired delimiters
--- Usage: Select text in visual mode, press 'sw', then type the delimiter
set("v", "sw", function()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local start_pos = vim.fn.getpos("'<")
	local cursor_offset = cursor_pos[2] - (start_pos[3] - 1)

	vim.cmd('normal! "xy')
	local selected_text = vim.fn.getreg("x")

	local char = vim.fn.getchar()
	char = type(char) == "number" and vim.fn.nr2char(char) or char

	local surrounds = {
		["("] = { "(", ")" },
		[")"] = { "(", ")" },
		["["] = { "[", "]" },
		["]"] = { "[", "]" },
		["{"] = { "{", "}" },
		["}"] = { "{", "}" },
		["<"] = { "<", ">" },
		[">"] = { "<", ">" },
		["'"] = { "'", "'" },
		['"'] = { '"', '"' },
		["`"] = { "`", "`" },
	}

	if surrounds[char] then
		local left, right = surrounds[char][1], surrounds[char][2]
		local new_text = left .. selected_text .. right
		vim.cmd('normal! gv"_c' .. new_text)
		vim.api.nvim_win_set_cursor(0, { cursor_pos[1], start_pos[3] - 1 + cursor_offset + 1 })
	else
		print("Unsupported character. Use one of: (, [, {, <, ', \", `")
	end
end, opts({ desc = "Surround selection with delimiter" }))

-- -------------------------------------------------------------------------
-- Editing Utilities
-- -------------------------------------------------------------------------
set(
	"n",
	"<leader>rw",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	opts({ desc = "Replace word under cursor globally" })
)

-- -------------------------------------------------------------------------
-- Splits
-- -------------------------------------------------------------------------
set("n", "<leader>|", function()
	vim.cmd("vsplit | enew")
end, opts({ desc = "Split vertically (new buffer)" }))

set("n", "<leader>-", function()
	vim.cmd("split | enew")
end, opts({ desc = "Split horizontally (new buffer)" }))

set("n", "<leader>x", ":close<CR>", opts({ desc = "Close current split" }))
set("n", "<S-k>", ":resize +2<CR>", { silent = true, desc = "Increase split height" })
set("n", "<S-j>", ":resize -2<CR>", { silent = true, desc = "Decrease split height" })
set("n", "<S-h>", ":vertical resize -2<CR>", { silent = true, desc = "Decrease split width" })
set("n", "<S-l>", ":vertical resize +2<CR>", { silent = true, desc = "Increase split width" })

-- -------------------------------------------------------------------------
-- Split / Buffer Navigation
-- -------------------------------------------------------------------------

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

-- -------------------------------------------------------------------------
-- Buffers
-- -------------------------------------------------------------------------
set("n", "<leader>bn", "<cmd> enew <CR>", opts({ desc = "New buffer" }))
set("n", "<leader>b", "<cmd>BufferLinePick<CR>", opts({ desc = "Pick buffer from bufferline" }))
set("n", "<leader>bd", ":bdelete!<CR>", opts({ desc = "Delete buffer" }))

-- Prevent space from being treated as leader in terminal mode
set("t", "<Space>", "<Space>", opts({ desc = "Send literal space in terminal mode" }))

-- -------------------------------------------------------------------------
-- Terminal Cursor Navigation
-- -------------------------------------------------------------------------
set("t", "<C-b>", [[<Esc>b]], opts({ desc = "Move backward by word in terminal" }))
set("t", "<C-w>", [[<Esc>f]], opts({ desc = "Move forward by word in terminal" }))
set("t", "<C-0>", [[<C-a>]], opts({ desc = "Move to beginning of line in terminal" }))
set("t", "<C-s>", [[<C-a>]], opts({ desc = "Move to beginning of line in terminal" }))
set("t", "<C-$>", [[<C-e>]], opts({ desc = "Move to end of line in terminal" }))
set("t", "<C-e>", [[<C-e>]], opts({ desc = "Move to end of line in terminal" }))

-- -------------------------------------------------------------------------
-- Comments
-- -------------------------------------------------------------------------
set({ "n", "v" }, "<leader>/", "gcc", opts({ remap = true, silent = true, desc = "Toggle comment" }))

-- -------------------------------------------------------------------------
-- Web
-- -------------------------------------------------------------------------
set("v", "gb", function()
	vim.cmd('normal! "xy')
	local selected_text = vim.fn.getreg("x")
	print("Selected text: " .. selected_text)
	local encoded = selected_text
		:gsub("([^%w%-%.%_%~ ])", function(c)
			return string.format("%%%02X", string.byte(c))
		end)
		:gsub(" ", "+")
	local url = "https://google.com/search?q=" .. encoded
	print("Opening URL: " .. url)
	vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end, opts({ desc = "Google search selected text" }))

-- -------------------------------------------------------------------------
-- Plugins
-- -------------------------------------------------------------------------
set("n", "<leader>d", "<cmd>CodeDiff<CR>", opts({ desc = "Open code diff", remap = true }))
