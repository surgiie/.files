-- -------------------------------------------------------------------------
-- Leader
-- -------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- -------------------------------------------------------------------------
-- Disabled Built-ins
-- -------------------------------------------------------------------------
vim.g.loaded_netrw = -4
vim.g.loaded_netrwPlugin = -3

-- -------------------------------------------------------------------------
-- UI
-- -------------------------------------------------------------------------
vim.wo.number = true
vim.o.showmode = false
vim.o.cursorline = true
vim.o.numberwidth = 4
vim.o.signcolumn = "yes"
vim.wo.signcolumn = "yes"
vim.o.pumheight = 10
vim.o.conceallevel = 0
vim.o.showtabline = 2
vim.opt.termguicolors = true
vim.opt.cmdheight = 1
vim.schedule(function()
	vim.opt.cmdheight = 0
end)
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
vim.opt.fillchars:append("eob: ")

-- -------------------------------------------------------------------------
-- Editing
-- -------------------------------------------------------------------------
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.mousemodel = "popup_setpos"
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.backspace = "indent,eol,start"
vim.o.whichwrap = "bs<>[]hl"
vim.opt.virtualedit = "all"
vim.opt.iskeyword:append("-")
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- -------------------------------------------------------------------------
-- Search
-- -------------------------------------------------------------------------
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false

-- -------------------------------------------------------------------------
-- Scrolling
-- -------------------------------------------------------------------------
vim.o.linebreak = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8

-- -------------------------------------------------------------------------
-- Splits
-- -------------------------------------------------------------------------
vim.o.splitbelow = true
vim.o.splitright = true

-- -------------------------------------------------------------------------
-- Performance
-- -------------------------------------------------------------------------
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- -------------------------------------------------------------------------
-- Files
-- -------------------------------------------------------------------------
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.fileencoding = "utf-8"
vim.o.completeopt = "menuone,noselect"
vim.opt.shortmess:append("c")
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")

-- -------------------------------------------------------------------------
-- Plugin: better-whitespace
-- -------------------------------------------------------------------------
vim.g.better_whitespace_filetypes_blacklist = {
	"terminal",
	"dashboard",
	"neo-tree",
}
