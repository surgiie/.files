-- Plugins with zero or not a lot of config.misc
return {
	-- No config
	{ "matze/vim-move" },
	{ "mg979/vim-visual-multi" },
	{ "ntpeters/vim-better-whitespace" },
	{ "echasnovski/mini.nvim", version = false },

	-- Minimal config
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	},
	{
		-- "surgiie/encbuf.nvim",
		dir = "~/projects/encbuf.nvim",
		config = function()
			require("encbuf").setup({})
		end,
	},
	{
		"surgiie/yaml-language-highlight.nvim",
		name = "yaml-language-highlight",
		config = function()
			require("yaml-language-highlight").setup({
				injections = {
					bash = { "run", "command", "entrypoint", "*.sh" },
					php = { "php", "*.php" },
					python = { "py", "*.py" },
					xml = { "xml", "*.xml" },
				},
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		opts = {
			render_modes = true,
			sign = {
				enabled = false,
			},
			completions = { lsp = { enabled = true } },
		},
		config = function(_, opts)
			require("render-markdown").setup({
				code = { highlight_border = false },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
		opts = {
			focus = true,
		},
		cmd = "Trouble",
		keys = {
			{ "<leader>ct", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
			{ "<leader>ctf", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
		},
	},
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.api.nvim_set_keymap("i", "<C-CR>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
			-- WSL: ConPTY strips <C-CR>, so WezTerm sends this explicit CSI-u sequence instead
			vim.api.nvim_set_keymap("i", "<Esc>[13;5u", 'copilot#Accept("<CR>")', { expr = true, silent = true })
		end,
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({
				default_mappings = false,
				mappings = {
					i = {
						[" "] = {
							[" "] = "<Esc>",
						},
					},
				},
			})
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup({
				mapping = {
					["tab"] = {
						map = "<Tab>",
						cmd = "<cmd>lua require('spectre').tab()<cr>",
						desc = "next query",
					},
					["shift-tab"] = {
						map = "<S-Tab>",
						cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
						desc = "previous query",
					},
					["toggle_line"] = {
						map = "dd",
						cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
						desc = "toggle item",
					},
					["enter_file"] = {
						map = "<cr>",
						cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
						desc = "open file",
					},
					["send_to_qf"] = {
						map = "<S-q>",
						cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
						desc = "send all items to quickfix",
					},
					["replace_cmd"] = {
						map = "<S-c>",
						cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
						desc = "input replace command",
					},
					["show_option_menu"] = {
						map = "<S-o>",
						cmd = "<cmd>lua require('spectre').show_options()<CR>",
						desc = "show options",
					},
					["run_current_replace"] = {
						map = "<S-x>",
						cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
						desc = "replace current line",
					},
					["run_replace"] = {
						map = "<S-r>",
						cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
						desc = "replace all",
					},
					["change_view_mode"] = {
						map = "<S-v>",
						cmd = "<cmd>lua require('spectre').change_view()<CR>",
						desc = "change result view mode",
					},
					["change_replace_sed"] = {
						map = "trs",
						cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
						desc = "use sed to replace",
					},
					["change_replace_oxi"] = {
						map = "tro",
						cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
						desc = "use oxi to replace",
					},
					["toggle_live_update"] = {
						map = "tu",
						cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
						desc = "update when vim writes to file",
					},
					["toggle_ignore_case"] = {
						map = "ti",
						cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
						desc = "toggle ignore case",
					},
					["toggle_ignore_hidden"] = {
						map = "th",
						cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
						desc = "toggle search hidden",
					},
					["resume_last_search"] = {
						map = "<S-l>",
						cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
						desc = "repeat last search",
					},
					["select_template"] = {
						map = "<S-p>",
						cmd = "<cmd>lua require('spectre.actions').select_template()<CR>",
						desc = "pick template",
					},
					["delete_line"] = {
						map = "<S-d>",
						cmd = "<cmd>lua require('spectre.actions').run_delete_line()<CR>",
						desc = "delete line",
					},
					-- you can put your mapping here it only use normal mode
				},
				find_engine = {
					["rg"] = {
						cmd = "rg",
						args = {
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
						},
					},
				},
			})
			vim.keymap.set("n", "<leader>rr", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
				desc = "Search Replace Current",
			})
			vim.keymap.set("n", "<leader>r", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Search Replace",
			})
		end,
	},
	{
		"voldikss/vim-floaterm",
		lazy = false,
		config = function()
			vim.keymap.set("n", "`", ":FloatermToggle scratch<CR>", { desc = "Open Terminal", silent = true })
			vim.keymap.set(
				"t",
				"`",
				"<C-\\><C-n>:FloatermToggle scratch<CR>",
				{ desc = "Open Terminal", silent = true }
			)
			vim.g.floaterm_gitcommit = "floaterm"
			vim.g.floaterm_autoinsert = 1
			vim.g.floaterm_wintype = "split"
			vim.g.floaterm_wintitle = 0
		end,
	},
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {}, -- needed even when using default config
		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
		config = function()
			vim.keymap.set("n", "<leader>f", function()
				require("origami").h()
			end)
			vim.keymap.set("n", "<Right>", function()
				require("origami").l()
			end)
			vim.keymap.set("n", "<End>", function()
				require("origami").dollar()
			end)
		end,
	},
	{
		"echasnovski/mini.splitjoin",
		config = function()
			local miniSplitJoin = require("mini.splitjoin")
			miniSplitJoin.setup({
				mappings = { toggle = "" }, -- Disable default mapping
			})
			vim.keymap.set({ "n", "x" }, "ja", function()
				miniSplitJoin.join()
			end, { desc = "Join arguments" })
			vim.keymap.set({ "n", "x" }, "sa", function()
				miniSplitJoin.split()
			end, { desc = "Split arguments" })
		end,
	},
	{
		"chrisgrieser/nvim-recorder",
		config = function()
			require("recorder").setup({
				mapping = {
					startStopRecording = "m",
					playMacro = "M",
					deleteAllMacros = "md",
					yankMacro = "ym",
				},
			})
		end,
	},
}
