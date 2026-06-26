-- Plugins with zero or not a lot of config.misc
return {
	{ "matze/vim-move" },
	{ "mg979/vim-visual-multi" },
	{
		"ntpeters/vim-better-whitespace",
		config = function()
			vim.g.better_whitespace_filetypes_blacklist = {
				"terminal",
				"dashboard",
				"neo-tree",
			}
		end,
	},
	-- Neovim API completions and type annotations for lua files
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	},
	{
		"surgiie/encbuf.nvim",
		config = function()
			require("encbuf").setup({
				encryption_method = "passphrase",
				passphrase = {
					source = "env",
				},
			})
		end,
	},
	{
		"surgiie/yaml-language-highlight.nvim",
		-- dir = "~/projects/yaml-language-highlight",
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
			keys = {
				["<cr>"] = "jump_close",
			},
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
			vim.g.copilot_assume_mapped = true
			vim.api.nvim_set_keymap("i", "<C-CR>", 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = false })
			-- WSL: ConPTY strips <C-CR>, so WezTerm sends this explicit CSI-u sequence instead
			vim.api.nvim_set_keymap("i", "<Esc>[13;5u", 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = false })
			vim.keymap.set("i", "<M-Right>", "<Plug>(copilot-accept-word)")
			-- zsh bindkey '^[l' (forward-word) means Alt-Right arrives as \el, so map raw sequence too
			vim.keymap.set("i", "<Esc>l", "<Plug>(copilot-accept-word)")
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
					["show_help"] = {
						map = "<S-h>",
						cmd = "<cmd>lua require('spectre').show_help()<CR>",
						desc = "show help",
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
}
