vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Disable Spacebar For Leader" })



-- Leader key mappings
vim.keymap.set("n", "<leader>`", "<cmd> Neoformat <CR>", { noremap = true, silent = true, desc = "Format File" })
vim.keymap.set("n", "<Leader>s", "^", { noremap = true, silent = true, desc = "Move to start of line" })

vim.keymap.set("n", "<leader>bn", "<cmd> enew <CR>", { noremap = true, silent = true, desc = "New Buffer" })
vim.keymap.set("n", "<leader>l", ":bnext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
vim.keymap.set("n", "<leader>b", "<cmd>BufferLinePick<CR>" , { noremap = true, silent = true, desc = "List Buffers For Pick" })
vim.keymap.set("n", "<leader>h", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", { noremap = true, silent = true, desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { noremap = true, silent = true, desc = "Split Window Vertically" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { noremap = true, silent = true, desc = "Split Window Horizontally" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { noremap = true, silent = true, desc = "Equalize Window Sizes" })
vim.keymap.set("n", "<leader>wc", ":close<CR>", { noremap = true, silent = true, desc = "Close Window" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>st", "gg", { noremap = true, desc = "Scroll To Top Of File" })
vim.keymap.set(
	"n",
	"<leader>sb",
	'<Cmd>lua vim.cmd("normal! G")<CR>',
	{ noremap = true, silent = true, desc = "Scroll To Bottom Of File" }
)
vim.keymap.set("n", "<Leader>e", "$", { noremap = true, silent = true, desc = "Move to end of line" })
-- Ctrl + <key> mappings
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", { noremap = true, silent = true, desc = "Quit File" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save File", silent = true })
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><Esc>", { desc = "Save File", noremap = true, silent = true })
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true, desc = "Move Cursor Left" })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true, desc = "Move Cursor Down" })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true, desc = "Move Cursor Up" })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true, desc = "Move Cursor Right" })
vim.keymap.set("i", "<C-z>", "<C-O>u<C-O>$", { noremap = true, silent = true, desc = "Undo" })
vim.keymap.set("n", "<C-a>", function()
	vim.cmd("normal! ggVG")
end, { noremap = true, silent = true, desc = "Select All Text" })
vim.keymap.set("i", "<C-a>", function()
	vim.cmd("normal! ggVG")
end, { noremap = true, silent = true, desc = "Select All Text" })

vim.keymap.set("i", "<C-y>", function()
	local pos = vim.fn.getpos(".")
	vim.cmd("redo")
	vim.fn.setpos(".", pos)
end, { silent = true, noremap = true, desc = "Redo Last Change" })

vim.keymap.set("i", "<C-x>", "<Del>", { noremap = true, silent = true, desc = "Delete Character" })
vim.keymap.set("v", "<C-x>", '"+c', { noremap = true, silent = true, desc = "Cut Selected Text" })
vim.keymap.set("v", "<C-c>", '"+yi', { noremap = true, desc = "Copy Selected Text" })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set("i", "<C-v>", '<Esc>"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
-- Alt + <key> mappings

vim.keymap.set({ "n", "i" }, "<A-j>", "<Esc>:move .+1<CR>==", { desc = "Move Line Down" })
vim.keymap.set({ "n", "i" }, "<A-Down>", "<Esc>:move .+1<CR>==", { desc = "Move Line Down" })
vim.keymap.set({ "n", "i" }, "<A-k>", "<Esc>:move .-2<CR>==", { desc = "Move Line Up" })
vim.keymap.set({ "n", "i" }, "<A-Up>", "<Esc>:move .-2<CR>==", { desc = "Move Line Up" })
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move Selection Up" })
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move Selection Down" })

-- Shift + <key> mappings
vim.keymap.set({ "n", "v" }, "<S-j>", "5j", { desc = "Move Cursor Down by 5 Lines", noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<S-k>", "5k", { desc = "Move Cursor Up by 5 Lines", noremap = true, silent = true })
vim.keymap.set(
	{ "n", "v" },
	"<S-h>",
	"5h",
	{ desc = "Move Cursor Left by 5 Characters", noremap = true, silent = true }
)
vim.keymap.set(
	{ "n", "v" },
	"<S-l>",
	"5l",
	{ desc = "Move Cursor Right by 5 Characters", noremap = true, silent = true }
)
vim.keymap.set('n', '<S-x>', 'd$', { noremap = true, silent = true, desc = 'Delete to end of line' })

-- Single character keymappings
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "Delete Single Character" })
vim.keymap.set("n", "d", '"_d', { noremap = true, desc = "Delete Line Without Register/Copy" })
vim.keymap.set("n", "dd", '"_dd', { noremap = true, desc = "Delete Line Without Register/Copy" })
vim.keymap.set("v", "d", '"_d', { noremap = true, desc = "Delete Selection Copy/Register" })
vim.keymap.set("v", "x", '"_x', { noremap = true, desc = "Delete Selection Without Copy/Register" })

-- Tab mappings
vim.keymap.set("n", "<Tab>", ">>", { noremap = true, silent = true, desc = "Indent Line" })
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true, silent = true, desc = "Unindent Line" })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true, desc = "Indent Line" })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true, desc = "Unindent Line" })
vim.keymap.set("i", "<S-Tab>", "<C-\\><C-N><<<C-\\><C-N>^i", { desc = "Unindent Line" })
