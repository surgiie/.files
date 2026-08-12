-- -------------------------------------------------------------------------
-- Monitors
-- -------------------------------------------------------------------------
hl.monitor({ output = "",      mode = "preferred", position = "auto", scale = 1, bitdepth = 10 })
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1, bitdepth = 10 })

-- -------------------------------------------------------------------------
-- Workspaces
-- -------------------------------------------------------------------------
hl.workspace_rule({ workspace = "name:1", monitor = "HDMI-A-1" })

-- -------------------------------------------------------------------------
-- Window rules
-- -------------------------------------------------------------------------
hl.window_rule({
	name = "wezterm-border",
	match = { class = "org.wezfurlong.wezterm" },
	border_size = 4,
})
hl.window_rule({
	name = "zoom-float",
	match = { class = "zoom" },
	float = true,
})
