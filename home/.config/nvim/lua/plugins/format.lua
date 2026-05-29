return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		local formatters_by_ft = {
			nix = { "nixfmt" },
		}

		if is_executable("shfmt") then
			formatters_by_ft.sh = { "shfmt" }
		end

		if is_executable("stylua") then
			formatters_by_ft.lua = { "stylua" }
		end

		if is_executable("python3") or is_executable("python") then
			formatters_by_ft.python = { "ruff_format" }
		end

		if is_executable("php") then
			formatters_by_ft.php = { "pint" }
		end

		if is_executable("node") or is_executable("npm") then
			formatters_by_ft.javascript = { "prettier", "prettierd", stop_after_first = true }
			formatters_by_ft.yaml = { "prettier", "prettierd", stop_after_first = true }
		end

		if is_executable("terraform") then
			formatters_by_ft.terraform = { "terraform_fmt" }
			formatters_by_ft.tf = { "terraform_fmt" }
		end

		if is_executable("xmllint") then
			formatters_by_ft.xml = { "xmllint" }
		end

		conform.setup({
			formatters_by_ft = formatters_by_ft,
			format_on_save = function(bufnr)
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
	end,
}
