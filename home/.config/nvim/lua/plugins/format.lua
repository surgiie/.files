return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		-- Build formatters_by_ft table conditionally based on installed languages
		local formatters_by_ft = {
			nix = { "nixfmt" },
		}

		-- sh - only if bash/sh is installed
		if is_executable("shfmt") then
			formatters_by_ft.sh = { "shfmt" }
		end

		-- lua - only if lua is installed (usually available in Neovim)
		if is_executable("stylua") then
			formatters_by_ft.lua = { "stylua" }
		end

		-- python - only if python is installed
		if is_executable("python3") or is_executable("python") then
			formatters_by_ft.python = { "ruff_format" }
		end

		-- php - only if php is installed
		if is_executable("php") then
			formatters_by_ft.php = { "pint" }
		end

		-- javascript - only if node/npm is installed
		if is_executable("node") or is_executable("npm") then
			formatters_by_ft.javascript = { "prettier", "prettierd", stop_after_first = true }
		end

		conform.setup({
			formatters_by_ft = formatters_by_ft,
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				local disable_filetypes = { c = true, cpp = true }

				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				end
				return {
					lsp_fallback = false,
					async = false,
					timeout_ms = 1000,
				}
			end,
		})

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})
		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file.", remap = true })
	end,
}
