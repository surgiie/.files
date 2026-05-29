return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		local eslint = lint.linters.eslint_d

		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			python = { "pylint" },
		}


		eslint.args = {
			"--no-warn-ignored",
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			function()
				return vim.fn.expand("%:p")
			end,
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				vim.diagnostic.config({ virtual_lines = true })
			end,
		})

		vim.api.nvim_create_autocmd("InsertEnter", {
			group = lint_augroup,
			callback = function()
				vim.diagnostic.config({ virtual_lines = false })
			end,
		})

		vim.keymap.set("n", "<leader>cl", function()
			require("lsp_lines").toggle()
		end, { desc = "Toggle code linting for current file" })
	end,
}
