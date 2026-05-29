return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = false,
			popup_border_style = "rounded",
			use_popups_for_input = false,
			enable_git_status = true,
			enable_diagnostics = true,
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
			sort_case_insensitive = false,
			sort_function = nil,
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					indent_size = 2,
					padding = 0,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					with_expanders = nil,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "󰜌",
					provider = function(icon, node, _)
						if node.type == "file" or node.type == "terminal" then
							local success, web_devicons = pcall(require, "nvim-web-devicons")
							local name = node.type == "terminal" and "terminal" or node.name
							if success then
								local devicon, hl = web_devicons.get_icon(name)
								icon.text = devicon or icon.text
								icon.highlight = hl or icon.highlight
							end
						end
					end,
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "✚",
						modified = "(e)",
						deleted = "(d)",
						renamed = "🔀",
						untracked = "",
						ignored = "",
						unstaged = "⚠️",
						staged = "",
						conflict = " X",
					},
				},
				file_size = {
					enabled = true,
					required_width = 64,
				},
				type = {
					enabled = true,
					required_width = 122,
				},
				last_modified = {
					enabled = true,
					required_width = 88,
				},
				created = {
					enabled = true,
					required_width = 110,
				},
				symlink_target = {
					enabled = false,
				},
			},
			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = false,
				hijack_netrw_behavior = "disabled",
				use_libuv_file_watcher = false,
				window = {
					mappings = {
						["/"] = "noop",
						["#"] = "noop",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["  "] = "clear_filter",
					},
					fuzzy_finder_mappings = {
						["<down>"] = "move_cursor_down",
						["<C-n>"] = "move_cursor_down",
						["<up>"] = "move_cursor_up",
						["<C-p>"] = "move_cursor_up",
					},
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = true,
				show_unloaded = true,
				window = {
					mappings = {
						["bd"] = "buffer_delete",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
					},
				},
			},
		})
		vim.keymap.set(
			"n",
			"<leader>t",
			":Neotree toggle reveal position=left<CR>",
			{ noremap = true, silent = true, desc = "Toggle File Tree (Neotree)" }
		)
	end,
}
