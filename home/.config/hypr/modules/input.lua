-- -------------------------------------------------------------------------
-- Environment
-- -------------------------------------------------------------------------
local home = os.getenv("HOME")

hl.env("PATH", home .. "/.local/bin:" .. os.getenv("PATH"))
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- -------------------------------------------------------------------------
-- Input
-- -------------------------------------------------------------------------
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "ctrl:nocaps",
		kb_rules = "",

		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
			clickfinger_behavior = true,
		},
	},
})

-- -------------------------------------------------------------------------
-- Devices
-- -------------------------------------------------------------------------
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
