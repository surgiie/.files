-- Standalone plugins with less than very little lines of config go here
return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		opts = {
			keywords = {
				SEE = { icon = "👁", color = "info" },
				see = { icon = "👁", color = "info" },
			},
		},
	},
	{
		"windwp/nvim-ts-autotag",
	},
	{
		"f-person/git-blame.nvim",
		lazy = false,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<space>fs", ":Telescope file_browser<CR>")

			-- open file_browser with the path of the current buffer
			vim.keymap.set("n", "<space>fsc", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
		end,
	},
	{
		"sbdchd/neoformat",
	},
	{
		-- Add the Laravel.nvim plugin which gives the ability to run Artisan commands
		-- from Neovim.
		"adalessa/laravel.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"tpope/vim-dotenv",
			"MunifTanjim/nui.nvim",
			"nvimtools/none-ls.nvim",
			"kevinhwang91/promise-async",
		},
		cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
		keys = {
			{ "<leader>la", ":Laravel artisan<cr>" },
			{ "<leader>lr", ":Laravel routes<cr>" },
			{ "<leader>lm", ":Laravel related<cr>" },
		},
		event = { "VeryLazy" },
		config = true,
		opts = {
			lsp_server = "intelephense",
			features = { null_ls = { enable = false } },
		},
	},
	{
		-- Add the blade-nav.nvim plugin which provides Goto File capabilities
		-- for Blade files.
		"ricardoramirezr/blade-nav.nvim",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		ft = { "blade", "php" },
	},
	{
		"ntpeters/vim-better-whitespace",
	},
	{
		"airblade/vim-rooter",
		setup = function()
			vim.g.rooter_manual_only = 1
		end,
		config = function()
			vim.cmd("Rooter")
		end,
	},
	{
		-- Tmux & split window navigation
		"christoomey/vim-tmux-navigator",
	},
	{
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
			vim.keymap.set("n", "<leader>src", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
				desc = "Search Replace Current",
			})
			vim.keymap.set("n", "<leader>sr", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Search Replace",
			})
		end,
	},
	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- High-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{ "<leader>gb", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"mattn/emmet-vim",
	}
}
