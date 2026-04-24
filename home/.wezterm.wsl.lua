-- ---------------------------------------------------------------------------
-- WSL wezterm config - identical as main one but managed separately,
-- cause you know, windows. :D
------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- Imports
-- ---------------------------------------------------------------------------
local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()
-- ---------------------------------------------------------------------------
-- Boot Options
-- ---------------------------------------------------------------------------
config.default_domain = "WSL:NixOS"
-- ---------------------------------------------------------------------------
-- Graphics
-- ---------------------------------------------------------------------------
config.enable_kitty_graphics = true
-- ---------------------------------------------------------------------------
-- Display
-- ---------------------------------------------------------------------------

config.font = wezterm.font_with_fallback({
	"GohuFont uni11 Nerd Font",
	"Symbols Nerd Font Mono",
	"FiraCode Nerd Font",
})
config.window_decorations = "NONE"
config.enable_scroll_bar = false
config.min_scroll_bar_height = "2cell"
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_and_split_indices_are_zero_based = false
config.warn_about_missing_glyphs = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- ---------------------------------------------------------------------------
-- Colors
-- ---------------------------------------------------------------------------
config.colors = {
	tab_bar = {
		background = "#212121",
		active_tab = {
			bg_color = "#e2e2e2",
			fg_color = "#212121",
		},
		inactive_tab = {
			bg_color = "#2C2C2C",
			fg_color = "#616161",
		},
		inactive_tab_hover = {
			bg_color = "#353535",
			fg_color = "#EEFFFF",
		},
		new_tab = {
			bg_color = "#212121",
			fg_color = "#616161",
		},
		new_tab_hover = {
			bg_color = "#2C2C2C",
			fg_color = "#EEFFFF",
		},
	},
}

-- ---------------------------------------------------------------------------
-- Background
-- ---------------------------------------------------------------------------
local backgroundSource = "\\\\wsl.localhost\\NixOS\\home\\nixos\\.files\\terminal.jpg"

config.background = {
	{
		source = {
			File = backgroundSource,
		},
		hsb = { brightness = 0.1 },
	},
}

-- ---------------------------------------------------------------------------
-- Startup
-- ---------------------------------------------------------------------------
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- ---------------------------------------------------------------------------
-- Helper Functions
-- ---------------------------------------------------------------------------
local function pane_is_shell(pane)
	return not pane:is_alt_screen_active()
end

-- ---------------------------------------------------------------------------
-- Leader Key
-- ---------------------------------------------------------------------------
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

-- ---------------------------------------------------------------------------
-- Key Bindings
-- ---------------------------------------------------------------------------
config.keys = {
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
	{ key = "Enter", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[13;5u" }) },
	{
		key = "Space",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{ key = "Space", mods = "ALT", action = wezterm.action({ SendKey = { key = "Space", mods = "ALT" } }) },
	{
		key = "b",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "b", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x1bb" }), pane)
			end
		end),
	},
	{
		key = "h",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "h", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x1b[D" }), pane)
			end
		end),
	},
	{
		key = "l",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "l", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x1b[C" }), pane)
			end
		end),
	},
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "w", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x1bf" }), pane)
			end
		end),
	},
	{
		key = "s",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "s", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x01" }), pane)
			end
		end),
	},
	{
		key = "e",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "e", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x05" }), pane)
			end
		end),
	},
	{
		key = "0",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "0", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x01" }), pane)
			end
		end),
	},
	{
		key = "$",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "$", mods = "CTRL|SHIFT" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x05" }), pane)
			end
		end),
	},
	{
		key = "x",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "x", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x1b[3~" }), pane)
			end
		end),
	},
	{
		key = "j",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "j", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x1b[B" }), pane)
			end
		end),
	},
	{
		key = "k",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "k", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ SendString = "\x1b[A" }), pane)
			end
		end),
	},
	{
		key = "j",
		mods = "ALT",
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
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			if not pane_is_shell(pane) then
				window:perform_action(wezterm.action.SendKey({ key = "k", mods = "ALT" }), pane)
			else
				window:perform_action(wezterm.action.ScrollByLine(-1), pane)
			end
		end),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "p",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "/",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER|SHIFT",
		key = "h",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER|SHIFT",
		key = "l",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER|SHIFT",
		key = "j",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER|SHIFT",
		key = "k",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendString("\n"),
	},
	{
		key = "d",
		mods = "CTRL",
		action = wezterm.action.ActivateKeyTable({
			name = "delete_mode",
			timeout_milliseconds = 2000,
		}),
	},
}

-- ---------------------------------------------------------------------------
-- Key Tables
-- ---------------------------------------------------------------------------
config.key_tables = {
	delete_mode = {
		{
			key = "b",
			action = wezterm.action_callback(function(window, pane)
				if not pane_is_shell(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "b", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action({ SendString = "\x17" }), pane)
				end
			end),
		},
		{
			key = "b",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if not pane_is_shell(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "b", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action({ SendString = "\x17" }), pane)
				end
			end),
		},
		{
			key = "w",
			action = wezterm.action_callback(function(window, pane)
				if not pane_is_shell(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "w", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action({ SendString = "\x1bd" }), pane)
				end
			end),
		},
		{
			key = "w",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if not pane_is_shell(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "w", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action({ SendString = "\x1bd" }), pane)
				end
			end),
		},
	},
}

-- ---------------------------------------------------------------------------
-- Tab Switching (LEADER + number)
-- ---------------------------------------------------------------------------
for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

-- ---------------------------------------------------------------------------
-- Status Line
-- ---------------------------------------------------------------------------
wezterm.on("update-right-status", function(window, _)
	local SOLID_LEFT_ARROW = ""
	local ARROW_FOREGROUND = { Foreground = { Color = "#fff" } }
	local prefix = ""

	if window:leader_is_active() then
		prefix = " " .. utf8.char(0x0001F525)
		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	end

	if window:active_tab():tab_id() ~= 0 then
		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
	end

	window:set_left_status(wezterm.format({
		{ Background = { Color = "#b7bdf8" } },
		{ Text = prefix },
		ARROW_FOREGROUND,
		{ Text = SOLID_LEFT_ARROW },
	}))
end)

-- ---------------------------------------------------------------------------
-- Mouse Bindings
-- ---------------------------------------------------------------------------
config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(wezterm.action.ClearSelection, pane)
			else
				window:perform_action(wezterm.action({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
}

-- ---------------------------------------------------------------------------
-- Return
-- ---------------------------------------------------------------------------
return config
