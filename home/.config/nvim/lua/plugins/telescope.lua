-- Add image support to telescope previews: https://github.com/3rd/image.nvim/issues/183
function telescope_image_preview()
	local supported_images = { "svg", "png", "jpg", "jpeg", "gif", "webp", "avif" }
	local from_entry = require("telescope.from_entry")
	local Path = require("plenary.path")
	local conf = require("telescope.config").values
	local Previewers = require("telescope.previewers")

	local previewers = require("telescope.previewers")
	local ok, image_api = pcall(require, "image")
	if not ok then return {} end

	local is_image_preview = false
	local image = nil
	local last_file_path = ""

	local is_supported_image = function(filepath)
		local split_path = vim.split(filepath:lower(), ".", { plain = true })
		local extension = split_path[#split_path]
		return vim.tbl_contains(supported_images, extension)
	end

	local delete_image = function()
		if not image then
			return
		end

		image:clear()

		is_image_preview = false
	end

	local create_image = function(filepath, winid, bufnr)
		image = image_api.hijack_buffer(filepath, winid, bufnr)

		if not image then
			return
		end

		vim.schedule(function()
			image:render()
		end)

		is_image_preview = true
	end

	local function defaulter(f, default_opts)
		default_opts = default_opts or {}
		return {
			new = function(opts)
				if conf.preview == false and not opts.preview then
					return false
				end
				opts.preview = type(opts.preview) ~= "table" and {} or opts.preview
				if type(conf.preview) == "table" then
					for k, v in pairs(conf.preview) do
						opts.preview[k] = vim.F.if_nil(opts.preview[k], v)
					end
				end
				return f(opts)
			end,
			__call = function()
				local ok, err = pcall(f(default_opts))
				if not ok then
					error(debug.traceback(err))
				end
			end,
		}
	end

	-- NOTE: Add teardown to cat previewer to clear image when close Telescope
	local file_previewer = defaulter(function(opts)
		opts = opts or {}
		local cwd = opts.cwd or vim.loop.cwd()
		return Previewers.new_buffer_previewer({
			title = "File Preview",
			dyn_title = function(_, entry)
				return Path:new(from_entry.path(entry, true)):normalize(cwd)
			end,

			get_buffer_by_name = function(_, entry)
				return from_entry.path(entry, true)
			end,

			define_preview = function(self, entry, _)
				local p = from_entry.path(entry, true)
				if p == nil or p == "" then
					return
				end

				conf.buffer_previewer_maker(p, self.state.bufnr, {
					bufname = self.state.bufname,
					winid = self.state.winid,
					preview = opts.preview,
				})
			end,

			teardown = function(_)
				if is_image_preview then
					delete_image()
				end
			end,
		})
	end, {})

	local buffer_previewer_maker = function(filepath, bufnr, opts)
		-- NOTE: Clear image when preview other file
		if is_image_preview and last_file_path ~= filepath then
			delete_image()
		end

		last_file_path = filepath

		if is_supported_image(filepath) then
			create_image(filepath, opts.winid, bufnr)
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end

	return { buffer_previewer_maker = buffer_previewer_maker, file_previewer = file_previewer.new }
end
return {
	"nvim-telescope/telescope.nvim",
	branch = "master", -- using master to fix issues with deprecated to definition warnings
	-- '0.1.x' for stable ver.
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"andrew-george/telescope-themes",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local function live_grep_with_ignored()
			builtin.live_grep({
				prompt_title = "Live Grep (Ignored)",
				additional_args = { "--hidden", "--no-ignore" },
			})
		end

		telescope.load_extension("themes")
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "file_browser")
		local defaults = {
			path_display = { "smart" },
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_previous, -- move to prev result
					["<C-j>"] = actions.move_selection_next, -- move to next result
					["<C-l>"] = actions.select_default, -- open file
				},
			},
		}
		if vim.fn.has("win32") == 0 then
			local image_preview = telescope_image_preview()
			defaults.file_previewer = image_preview.file_previewer
			defaults.buffer_previewer_maker = image_preview.buffer_previewer_maker
		end
		telescope.setup({
			defaults = defaults,
			extensions = {
				themes = {
					enable_previewer = true,
					enable_live_preview = true,
					persist = {
						enabled = true,
						path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
					},
				},
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>fw", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end, { desc = "Find Connected Words under cursor" })

		vim.keymap.set("n", "<leader>fib", builtin.current_buffer_fuzzy_find, { desc = "[F]ind [I]n Current [B]uffer" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({ hidden = true, file_ignore_patterns = { "node_modules", "%.git/", "%.venv" } })
		end, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>fi", function()
			builtin.find_files({ no_ignore = true, hidden = true, prompt_title = "[F]ind [F]iles [I]ignore" })
		end, { desc = "[F]ind [I]gnore Files" })
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep({
				file_ignore_patterns = { "node_modules", ".git/", ".venv" },
				additional_args = { "--hidden" },
			})
		end, { desc = "[F]ind [G]rep" })
		vim.keymap.set(
			"n",
			"<leader>fgi",
			live_grep_with_ignored,
			{ noremap = true, silent = true, desc = "[F]ind [G]rep [I]gnore" }
		) -- live_grep with ignored files
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
		vim.keymap.set(
			"n",
			"<leader>ts",
			"<cmd>Telescope themes<CR>",
			{ noremap = true, silent = true, desc = "Theme Switcher" }
		)
	end,
}
