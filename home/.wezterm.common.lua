-- Shared WezTerm configuration loaded by both .wezterm.lua (Linux) and
-- .wezterm.wsl.lua (Windows/WSL). Platform-specific settings live in each
-- entry file; everything here applies to both.
local wezterm = require("wezterm")
local M = {}

function M.apply(config, opts)
	opts = opts or {}

	-- pane_is_shell is platform-specific: Linux checks the process name,
	-- WSL uses is_alt_screen_active() since process detection is unreliable
	-- across the WSL boundary.
	local pane_is_shell = opts.pane_is_shell
		or function(pane)
			local process_name = pane:get_foreground_process_name() or ""
			local shells = { "bash", "zsh", "sh", "node" }
			for _, shell in ipairs(shells) do
				if process_name:find(shell) then
					return true
				end
			end
			return false
		end

	-- ── Font & display ────────────────────────────────────────────────────────
	config.font = wezterm.font_with_fallback({
		"GohuFont uni11 Nerd Font",
		"Symbols Nerd Font Mono",
		"FiraCode Nerd Font",
	})
	config.font_size = opts.font_size or 10
	config.window_decorations = "NONE"
	config.enable_scroll_bar = false
	config.min_scroll_bar_height = "2cell"
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.tab_and_split_indices_are_zero_based = false
	config.warn_about_missing_glyphs = false
	config.status_update_interval = 100
	config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

	-- ── Colors ────────────────────────────────────────────────────────────────
	config.colors = {
		tab_bar = {
			background = "#212121",
			active_tab = { bg_color = "#e2e2e2", fg_color = "#212121" },
			inactive_tab = { bg_color = "#2C2C2C", fg_color = "#616161" },
			inactive_tab_hover = { bg_color = "#353535", fg_color = "#EEFFFF" },
			new_tab = { bg_color = "#212121", fg_color = "#616161" },
			new_tab_hover = { bg_color = "#2C2C2C", fg_color = "#EEFFFF" },
		},
	}

	-- ── Startup ───────────────────────────────────────────────────────────────
	wezterm.on("gui-startup", function()
		local _, _, window = wezterm.mux.spawn_window({})
		window:gui_window():maximize()
	end)

	-- ── Leader ───────────────────────────────────────────────────────────────
	config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

	-- ── Helper: toggle bottom terminal pane ──────────────────────────────────
	local function toggle_terminal_pane(window, pane)
		local tab = pane:tab()
		local panes_with_info = tab:panes_with_info()
		if #tab:panes() == 1 then
			pane:split({ direction = "Bottom" })
			return
		end
		local is_zoomed = false
		for _, info in ipairs(panes_with_info) do
			if info.is_active then
				is_zoomed = info.is_zoomed
				break
			end
		end
		if is_zoomed then
			tab:set_zoomed(false)
			window:perform_action({ ActivatePaneDirection = "Down" }, pane)
		else
			window:perform_action({ ActivatePaneDirection = "Up" }, pane)
			tab:set_zoomed(true)
		end
	end

	-- ── Helper: navigate pane or tab ─────────────────────────────────────────
	-- Returns true if the tab has any vertical split (panes differ in their top position).
	-- h/l use pane nav only when a vertical split exists; otherwise switch tabs.
	-- j/k use pane nav only when a horizontal split exists; otherwise switch tabs.
	-- ── Helper: navigate pane or tab ─────────────────────────────────────────
	-- Side-by-side panes (differ in `left`) → h/l should use pane nav.
	-- Stacked panes (differ in `top`)       → j/k should use pane nav.
	local function has_side_by_side_split(tab)
		local infos = tab:panes_with_info()
		local first_left = infos[1] and infos[1].left
		for _, info in ipairs(infos) do
			if info.left ~= first_left then
				return true
			end
		end
		return false
	end

	local function has_stacked_split(tab)
		local infos = tab:panes_with_info()
		local first_top = infos[1] and infos[1].top
		for _, info in ipairs(infos) do
			if info.top ~= first_top then
				return true
			end
		end
		return false
	end

	local function navigate(pane_dir, tab_dir)
		return wezterm.action_callback(function(window, pane)
			local tab = window:active_tab()
			local use_pane = (pane_dir == "Left" or pane_dir == "Right") and has_side_by_side_split(tab)
				or (pane_dir == "Up" or pane_dir == "Down") and has_stacked_split(tab)
			if use_pane then
				window:perform_action(wezterm.action.ActivatePaneDirection(pane_dir), pane)
				window:perform_action(wezterm.action.PopKeyTable, pane)
			else
				window:perform_action(wezterm.action.ActivateTabRelative(tab_dir), pane)
			end
		end)
	end

	-- ── Key bindings ─────────────────────────────────────────────────────────
	config.keys = {
		{ mods = "LEADER", key = "t", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
		{
			mods = "LEADER",
			key = "/",
			action = wezterm.action.Multiple({
				wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
				wezterm.action.PopKeyTable,
			}),
		},
		{
			mods = "LEADER",
			key = "-",
			action = wezterm.action.Multiple({
				wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
				wezterm.action.PopKeyTable,
			}),
		},
		{ mods = "LEADER", key = "h", action = navigate("Left", -1) },
		{ mods = "LEADER", key = "l", action = navigate("Right", 1) },
		{ mods = "LEADER", key = "j", action = navigate("Down", 1) },
		{ mods = "LEADER", key = "k", action = navigate("Up", -1) },
		{
			key = "L",
			mods = "CTRL",
			action = wezterm.action.QuickSelectArgs({
				label = "open url",
				patterns = { '"(https?://[^"]+)"', "'(https?://[^']+)'", "https?://[^\\s\"']+" },
				-- skip_action_on_paste = true,
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.log_info("opening: " .. url)
					wezterm.run_child_process({ "browse", url })
				end),
			}),
		},
		{
			key = ";",
			mods = "LEADER",
			action = wezterm.action_callback(toggle_terminal_pane),
		},
		{
			key = "p",
			mods = "LEADER",
			action = wezterm.action.PaneSelect({ alphabet = "asdfghjkl" }),
		},
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if not pane_is_shell(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "f", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action.QuickSelect, pane)
				end
			end),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action_callback(function(window, pane)
				if not pane_is_shell(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "j", mods = "ALT" }), pane)
				else
					window:perform_action(wezterm.action.ScrollByLine(1), pane)
				end
			end),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action_callback(function(window, pane)
				if not pane_is_shell(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "k", mods = "ALT" }), pane)
				else
					window:perform_action(wezterm.action.ScrollByLine(-1), pane)
				end
			end),
		},
	}

	local custom_keys = opts.keys or {}
	for _, key in ipairs(custom_keys) do
		table.insert(config.keys, key)
	end

	-- ── Tab switching ─────────────────────────────────────────────────────────
	for i = 0, 9 do
		table.insert(config.keys, {
			key = tostring(i == 0 and 0 or i),
			mods = "LEADER",
			action = wezterm.action.ActivateTab(i - 1),
		})
	end

	-- ── Vim modes (normal/insert/shortcuts) + status bar ─────────────────────
	local vim_modes = wezterm.plugin.require("https://github.com/surgiie/wezterm-modes")
	-- local vim_modes = dofile(wezterm.home_dir .. "/projects/wezterm-modes/plugin/init.lua")
	local commands = opts.commands or {
		-- ── Git ───────────────────────────────────────────────────────────────
		{
			key = "gc",
			description = "Git — Commit — type message",
			execute = false,
			command = "git commit -m '<cursor>'",
		},
		{
			key = "gw",
			description = "Git — WIP — add all, commit, push",
			execute = false,
			command = "git add -A && git commit -m 'wip: <cursor>' && git push",
		},
		{ key = "ga", description = "Git — Add", command = "git add" },
		{ key = "gi", description = "Git — Rewrite — interactive rebase from selected commit", command = "git rewrite" },
		{
			key = "gs",
			description = "Git — Switch to selected branch",
			command = [=[branch=$(git branch --sort=-committerdate --format='%(refname:short)' | fzf --prompt='switch to> ') && [[ -n "$branch" ]] && git switch "$branch"]=],
		},
		{
			key = "gp",
			description = "Git — Cherry-pick selected commit",
			command = [=[hash=$(git log --all --oneline | fzf --prompt='cherry-pick> ' | awk '{print $1}') && [[ -n "$hash" ]] && git cherry-pick "$hash"]=],
		},
		{
			key = "gr",
			description = "Git — Restore file to selected commit",
			command = [=[file=$(git ls-files | fzf --prompt='restore file> ') && [[ -n "$file" ]] && ref=$(git log --oneline | fzf --prompt='restore from> ' | awk '{print $1}') && [[ -n "$ref" ]] && git restore --source="$ref" -- "$file"]=],
		},

		-- ── AWS ───────────────────────────────────────────────────────────────
		{
			key = "al",
			description = "AWS — SSO login — select profile",
			command = [=[profile=$(grep '^\[profile ' ~/.aws/config | sed 's/^\[profile //;s/\]$//' | fzf --prompt='profile> ') && [[ -n "$profile" ]] && aws sso login --profile "$profile"]=],
		},
		{
			key = "ae",
			description = "AWS — ECR docker login — select profile",
			command = [=[profile=$(grep '^\[profile ' ~/.aws/config | sed 's/^\[profile //;s/\]$//' | fzf --prompt='profile> ') && [[ -n "$profile" ]] && aws ecr get-login-password --profile "$profile" | docker login --username AWS --password-stdin "$(aws ecr describe-registry --profile "$profile" --query 'registryId' --output text).dkr.ecr.$(aws configure get region --profile "$profile").amazonaws.com"]=],
		},
		{
			key = "ap",
			description = "AWS — Set AWS_PROFILE — select profile",
			command = [=[profile=$(grep '^\[profile ' ~/.aws/config | sed 's/^\[profile //;s/\]$//' | fzf --prompt='profile> ') && [[ -n "$profile" ]] && export AWS_PROFILE="$profile" && echo "Set AWS_PROFILE to $profile"]=],
		},

		-- ── Browser ───────────────────────────────────────────────────────────
		{
			key = "bb",
			description = "Browser — Open a bookmark (fzf)",
			command = [=[url=$(jq -r '.roots | .. | objects | select(has("type") and .type == "url") | (if .name == "" then .url else .name end) + "\t" + .url' ~/.config/google-chrome/Default/Bookmarks | fzf --prompt='bookmarks> ' --with-nth=1 --delimiter=$'\t' | cut -f2) && [[ -n "$url" ]] && browse "$url"]=],
		},
		{
			key = "bs",
			description = "Browser — Search in browser",
			execute = false,
			command = "browse 'https://www.google.com/search?q=<cursor>'",
		},
		{ key = "bg", description = "Browser — Open current git repo", command = "git browse" },

		-- ── History ───────────────────────────────────────────────────────────
		{
			key = "hr",
			description = "History — Search and run from history",
			command = [=[cmd=$(grep -a '^: [0-9]*:[0-9]*;' ~/.zsh_history | strings | awk -F';' '{ $1=""; print substr($0,2) }' | tac | awk '!seen[$0]++' | fzf --prompt='history> ' --height=~40% --layout=reverse --border --no-sort) && [[ -n "$cmd" ]] && eval "$cmd"]=],
		},
		{
			key = "he",
			description = "History — Open history file in editor",
			command = "${EDITOR:-nvim} ~/.zsh_history",
		},

		-- ── Kubectl ───────────────────────────────────────────────────────────
		{ key = "kn", description = "Kubectl — Switch namespace", command = "kns" },
		{ key = "kl", description = "Kubectl — Log", execute = false, command = "kubectl logs:json <cursor>" },
		{ key = "kc", description = "Kubectl — Switch context", command = "kctx" },

		-- ── Misc ──────────────────────────────────────────────────────────────
		{ key = "v",  description = "Neovim — Open in current directory", command = "nvim ." },
		{ key = "vs", description = "Neovim — Scratchpad",                command = "nvim-scratch" },
	}
	vim_modes.apply_to_config(config, {
		commands = commands,
		icon = opts.icon or "",
		should_run = opts.should_run or function(pane, default_check)
			local proc = (pane:get_foreground_process_name() or ""):lower()
			if proc:find("claude", 1, true) then
				return true
			end
			return default_check(pane)
		end,
	})
end

return M
