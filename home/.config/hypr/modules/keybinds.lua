local vars = require("modules.vars")
local mainMod = vars.mainMod
local exec = vars.exec
local menu = vars.menu
local sounds = vars.sounds

-- -------------------------------------------------------------------------
-- Apps
-- -------------------------------------------------------------------------
hl.bind(
	mainMod .. " + T",
	exec(
		'hyprtoggle --class "org.wezfurlong.wezterm" --exec "wezterm"'
			.. ' --on-hide "ffplay -nodisp -autoexit '
			.. sounds
			.. '/windwaker/pause-close.mp3"'
			.. ' --on-focus "ffplay -nodisp -autoexit '
			.. sounds
			.. '/windwaker/pause.mp3"'
	)
)
hl.bind(mainMod .. " + E", exec('hyprtoggle --class "org.gnome.Nautilus" --exec "nautilus"'))
hl.bind(
	mainMod .. " + B",
	exec(
		'hyprtoggle --class "google-chrome" --exec "google-chrome-stable"'
			.. ' --on-hide "ffplay -nodisp -autoexit '
			.. sounds
			.. '/kingdom-hearts/pause-close.mp3"'
			.. ' --on-focus "ffplay -nodisp -autoexit '
			.. sounds
			.. '/kingdom-hearts/pause.mp3"'
			.. " --cycle-on-multiple"
	)
)
hl.bind(mainMod .. " + A", exec(menu))
hl.bind(mainMod .. " + V", exec("nvim-scratch"))

-- -------------------------------------------------------------------------
-- Windows
-- -------------------------------------------------------------------------
hl.bind(mainMod .. " + backspace", function()
	hl.dispatch(hl.dsp.focus({ last = true }))
	hl.timer(function()
		hl.dispatch(hl.dsp.window.fullscreen_state({ internal = 2, client = 0, action = "set" }))
	end, { timeout = 50, type = "oneshot" })
end)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({ internal = 2, client = 0, action = "toggle" }))
hl.bind(mainMod .. " + Q", exec("hyprclose"))
hl.bind(mainMod .. " + Tab", exec("hyprselect"))
hl.bind("ALT + Tab", exec("hyprselect"))

-- -------------------------------------------------------------------------
-- Focus
-- -------------------------------------------------------------------------
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))

-- -------------------------------------------------------------------------
-- Move Windows
-- -------------------------------------------------------------------------
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))

-- -------------------------------------------------------------------------
-- Workspaces
-- -------------------------------------------------------------------------
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- -------------------------------------------------------------------------
-- Mouse Pointer
-- -------------------------------------------------------------------------
hl.bind(
	mainMod .. " + M",
	exec("pgrep -x wl-kbptr > /dev/null && pkill -x wl-kbptr || (wl-kbptr -o modes=floating,click;)")
)
hl.bind(mainMod .. " + SHIFT + M", exec("pkill -x wl-kbptr; wl-kbptr -o modes=tile,click;"))

hl.bind(mainMod .. " + C", hl.dsp.submap("cursor"))
hl.define_submap("cursor", "reset", function()
	hl.bind("J", exec("wlrctl pointer move 0 10"), { repeating = true })
	hl.bind("K", exec("wlrctl pointer move 0 -10"), { repeating = true })
	hl.bind("L", exec("wlrctl pointer move 10 0"), { repeating = true })
	hl.bind("H", exec("wlrctl pointer move -10 0"), { repeating = true })
	hl.bind("space", exec("wlrctl pointer click left"), { repeating = true })
	hl.bind("SHIFT+space", exec("wlrctl pointer click right"), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind(mainMod .. " + C", hl.dsp.submap("reset"))
end)

-- -------------------------------------------------------------------------
-- Misc
-- -------------------------------------------------------------------------
hl.bind(
	mainMod .. " + S",
	exec("hyprshot -m region --clipboard-only && pgrep -x wl-kbptr > /dev/null && pkill -x wl-kbptr")
)
