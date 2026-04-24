return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- NOTE: LSP Keybinds
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings
				local opts = { buffer = ev.buf, silent = true }

				-- Keymaps
				opts.desc = "Show LSP references"
				vim.keymap.set("n", "cr", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "cD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "cd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "ci", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "ct", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", function()
					vim.lsp.buf.code_action()
				end, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>crn", vim.lsp.buf.rename, opts)

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "ci", function()
					vim.lsp.buf.hover({
						border = "rounded",
						max_width = 80,
						max_height = 15,
					})
				end, opts)
			end,
		})

		-- Define sign icons for each severity
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		-- Set diagnostic config
		vim.diagnostic.config({
			signs = {
				text = signs,
			},
			virtual_text = false,
			underline = true,
			update_in_insert = false,
		})

		-- Setup servers
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Global LSP settings (applied to all servers)
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Configure and enable LSP servers
		-- lua_ls (Lua is always available in Neovim)
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					runtime = {
						version = "LuaJIT",
						path = vim.split(package.path, ";"),
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- emmet_language_server
		vim.lsp.config("emmet_language_server", {
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"pug",
				"typescriptreact",
			},
			init_options = {
				includeLanguages = {},
				excludeLanguages = {},
				extensionsPath = {},
				preferences = {},
				showAbbreviationSuggestions = true,
				showExpandedAbbreviation = "always",
				showSuggestionsAsSnippets = false,
				syntaxProfiles = {},
				variables = {},
			},
		})
		vim.lsp.config("bashls", {
			filetypes = { "sh", "zsh", "bash" },
		})
		vim.lsp.enable("bashls")
		vim.lsp.enable("emmet_language_server")

		-- emmet_ls
		vim.lsp.config("emmet_ls", {
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
		})
		vim.lsp.enable("emmet_ls")

		-- ts_ls (TypeScript/JavaScript) - only enable if Node.js is installed
		if is_executable("node") or is_executable("npm") then
			vim.lsp.config("ts_ls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				single_file_support = true,
				init_options = {
					preferences = {
						includeCompletionsForModuleExports = true,
						includeCompletionsForImportStatements = true,
					},
				},
			})
			vim.lsp.enable("ts_ls")
		end
		-- intelephense (PHP) - only enable if PHP is installed
		if is_executable("php") then
			vim.lsp.config("intelephense", {})
			vim.lsp.enable("intelephense")
		end

		-- ruff (Python) - only enable if Python is installed
		if is_executable("python3") or is_executable("python") then
			vim.lsp.config("ruff", {})
			vim.lsp.enable("ruff")

			-- pylsp (Python) - only enable if Python is installed
			vim.lsp.config("pylsp", {
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = { enabled = false },
							flake8 = { enabled = false },
							pyflakes = { enabled = false },
							pylint = { enabled = false },
							black = { enabled = false },
							isort = { enabled = false },
						},
					},
				},
			})
			vim.lsp.enable("pylsp")
		end
	end,
}
