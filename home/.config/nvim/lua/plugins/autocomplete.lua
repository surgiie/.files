return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	branch = "main",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"f3fora/cmp-spell",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"nvim-treesitter/nvim-treesitter",
		"onsails/lspkind.nvim",
		"roobert/tailwindcss-colorizer-cmp.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local _, luasnip = pcall(require, "luasnip")
		local lspkind = require("lspkind")
		local colorizer = require("tailwindcss-colorizer-cmp").formatter

		local lsp_kinds = {
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Keyword = " ",
			Method = " ",
			Module = " ",
			Operator = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		}

		local confirm = function(entry)
			local behavior = cmp.ConfirmBehavior.Replace
			if entry then
				local completion_item = entry.completion_item
				local newText = ""
				if completion_item.textEdit then
					newText = completion_item.textEdit.newText
				elseif type(completion_item.insertText) == "string" and completion_item.insertText ~= "" then
					newText = completion_item.insertText
				else
					newText = completion_item.word or completion_item.label or ""
				end
				local diff_after = math.max(0, entry.replace_range["end"].character + 1) - entry.context.cursor.col
				if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
					behavior = cmp.ConfirmBehavior.Insert
				end
			end
			cmp.confirm({ select = true, behavior = behavior })
		end

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.api.nvim_create_autocmd("TextChangedI", {
			callback = function()
				if cmp.visible() and not cmp.get_selected_entry() then
					cmp.close()
				end
			end,
		})

		cmp.setup({
			completion = {
				autocomplete = false,
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					max_width = 40,
					max_height = 20,
				},
				completion = {
					border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
				},
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = cmp.config.sources({
				{ name = "luasnip" },
				{ name = "lazydev" },
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "tailwindcss-colorizer-cmp" },
				{
					name = "spell",
					option = {
						enable_in_context = function()
							local ft = vim.bo.filetype
							return ft == "markdown" or ft == "text"
						end,
					},
				},
			}),
			mapping = cmp.mapping.preset.insert({
				["<S-Tab>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item()
					else
						cmp.complete()
					end
				end, { "i", "s" }),
				["<C-c>"] = cmp.mapping.abort(),
				["<C-d>"] = cmp.mapping(function()
					cmp.close_docs()
				end, { "i", "s" }),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-j>"] = cmp.mapping(
					cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					{ "i", "s" }
				),
				["<C-k>"] = cmp.mapping(
					cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					{ "i", "s" }
				),
				["<C-n>"] = cmp.mapping(
					cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					{ "i", "s" }
				),
				["<C-p>"] = cmp.mapping(
					cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					{ "i", "s" }
				),
				["<Down>"] = cmp.mapping(
					cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					{ "i", "s" }
				),
				["<Up>"] = cmp.mapping(
					cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					{ "i", "s" }
				),
				["<C-y>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						confirm(entry)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() and cmp.get_selected_entry() then
						confirm(cmp.get_selected_entry())
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			formatting = {
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s %s", lsp_kinds[vim_item.kind] or "", vim_item.kind)
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
					})[entry.source.name]
					vim_item = lspkind.cmp_format({
						maxwidth = 25,
						ellipsis_char = "...",
					})(entry, vim_item)
					if entry.source.name == "nvim_lsp" then
						vim_item = colorizer(entry, vim_item)
					end
					vim_item.abbr = " " .. (vim_item.abbr or "")
					return vim_item
				end,
			},
		})
	end,
}
