local wezterm = require("wezterm")
local config = wezterm.config_builder()
local common = dofile(wezterm.home_dir .. "/.wezterm.common.lua")

config.enable_wayland = true
config.font_size = 16

local user = os.getenv("USER")
config.background = {
	{ source = { File = "/home/" .. user .. "/.files/terminal.jpg" }, hsb = { brightness = 0.1 } },
}

common.apply(config, {
	icon = "🔥",
})

return config
