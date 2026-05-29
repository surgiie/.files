return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = function(desc)
					return { buffer = ev.buf, silent = true, desc = desc }
				end

				vim.keymap.set({ "n", "v" }, "c", vim.lsp.buf.code_action, opts("Code actions"))
				vim.keymap.set("n", ".", "<cmd>Telescope lsp_definitions<CR>", opts("LSP definitions"))
				vim.keymap.set("n", "cr", vim.lsp.buf.rename, opts("Rename symbol"))
				vim.keymap.set("n", "?", function()
					vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 15 })
				end, opts("Hover documentation"))
			end,
		})

		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		vim.diagnostic.config({
			signs = {
				text = signs,
			},
			virtual_text = {
				severity = { min = vim.diagnostic.severity.WARN },
				prefix = "●",
				spacing = 4,
			},
			underline = true,
			update_in_insert = false,
		})

		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()
		vim.lsp.config("*", {
			capabilities = capabilities,
		})
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

		vim.lsp.config("emmet_language_server", {
			filetypes = {
				"css",
				"html",
				"javascript",
				"javascriptreact",
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

		if is_executable("php") then
			vim.lsp.config("intelephense", {})
			vim.lsp.enable("intelephense")
		end

		if is_executable("go") then
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
					},
				},
			})
			vim.lsp.enable("gopls")
		end

		if is_executable("nixd") then
			vim.lsp.config("nixd", {})
			vim.lsp.enable("nixd")
		elseif is_executable("nil") then
			vim.lsp.config("nil_ls", {})
			vim.lsp.enable("nil_ls")
		end

		if is_executable("lemminx") then
			vim.lsp.config("lemminx", {})
			vim.lsp.enable("lemminx")
		end

		if is_executable("python3") or is_executable("python") then
			vim.lsp.config("ruff", {})
			vim.lsp.enable("ruff")
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
