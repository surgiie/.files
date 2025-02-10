return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use Telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of `help_tags` options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		vim.cmd([[
            highlight link TelescopePromptTitle PMenuSel
            highlight link TelescopePreviewTitle PMenuSel
            highlight link TelescopePromptNormal NormalFloat
            highlight link TelescopePromptBorder FloatBorder
            highlight link TelescopeNormal CursorLine
            highlight link TelescopeBorder CursorLineBg
      ]])
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
						["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
						["<C-l>"] = require("telescope.actions").select_default, -- open file
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				["file_browser"] = {
					hidden = true, -- Show hidden files (dotfiles)
					respect_gitignore = false, -- Set to false to show files in .gitignore
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "file_browser")
		pcall(require("telescope").load_extension, "ui-select")

		-- Custom live_grep function that includes ignored files
		local builtin = require("telescope.builtin")
		local function live_grep_with_ignored()
			builtin.live_grep({
				prompt_title = "Live Grep (Ignored)",
				additional_args = { "--hidden", "--no-ignore" },
			})
		end

		vim.keymap.set(
			"n",
			"<leader>f",
			builtin.current_buffer_fuzzy_find,
			{ desc = "[S] Fuzzily search in current buffer" }
		)
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({ hidden = true,   file_ignore_patterns = { "node_modules", ".git/", ".venv" }, })
		end, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>fi", function()
			builtin.find_files({ no_ignore = true, hidden = true, prompt_title = "Find Files (Ignored)" })
		end, { desc = "[F]ind [F]iles With [I]gnore" })
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep({
				file_ignore_patterns = { "node_modules", ".git/", ".venv" },
				additional_args = { "--hidden" },
			})
		end, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader>fgi", live_grep_with_ignored, { noremap = true, silent = true }) -- live_grep with ignored files
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind Existing [B]uffers" })
	end,
}
