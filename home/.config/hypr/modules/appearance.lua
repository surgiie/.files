-- -------------------------------------------------------------------------
-- XWayland
-- -------------------------------------------------------------------------
hl.config({
	xwayland = { force_zero_scaling = true },
})

-- -------------------------------------------------------------------------
-- General
-- -------------------------------------------------------------------------
hl.config({
	general = {
		border_size = 0,
		resize_on_border = false,
		gaps_in = 0,
		gaps_out = 0,
		layout = "master",
		allow_tearing = false,
		col = {
			active_border = "rgba(212121FF)",
			inactive_border = "rgba(212121AA)",
		},
	},
})

-- -------------------------------------------------------------------------
-- Decoration
-- -------------------------------------------------------------------------
hl.config({
	decoration = {
		rounding = 0,
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
		},
	},
})

-- -------------------------------------------------------------------------
-- Animations
-- -------------------------------------------------------------------------
hl.config({ animations = { enabled = true } })

hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1.0 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

hl.animation({ leaf = "global",         enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",         enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",        enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",      enabled = false, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",     enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",         enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",        enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",           enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",         enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",       enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",      enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",   enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",  enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",     enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",   enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut",  enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })

-- -------------------------------------------------------------------------
-- Layout
-- -------------------------------------------------------------------------
hl.config({
	master = { orientation = "left" },
})

-- -------------------------------------------------------------------------
-- Window Rules
-- -------------------------------------------------------------------------
hl.window_rule({
	name  = "maximize-all",
	match = { class = ".*", float = false },
	maximize = true,
})

-- -------------------------------------------------------------------------
-- Misc
-- -------------------------------------------------------------------------
hl.config({
	misc = {
		focus_on_activate = true,
		force_default_wallpaper = 0,
		background_color = "rgb(272822)",
	},
})
