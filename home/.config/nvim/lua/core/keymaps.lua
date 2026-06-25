-- -- Helpers
-- -- -------------------------------------------------------------------------
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
--- Navigate to adjacent split or fallback to buffer navigation
--- @param dir string Direction: "h" (left), "l" (right), "j" (down), "k" (up)
local function navigate_buffer_or_split(dir)
	pcall(function()
		local manager = require("neo-tree.sources.manager")
		local state = manager.get_state("filesystem")
		if state and state.window and vim.api.nvim_win_is_valid(state.window.winid) then
			vim.cmd("Neotree close")
		end
	end)
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
set("n", "<leader>q", ":bdelete!<CR>", opts({ desc = "Delete buffer" }))
-- -------------------------------------------------------------------------
-- Comments
-- -------------------------------------------------------------------------
set({ "n", "v" }, "<leader>/", "gcc<Esc>", opts({ remap = true, silent = true, desc = "Toggle comment" }))
