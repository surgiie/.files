local wezterm = require("wezterm")
local config = wezterm.config_builder()
local common = dofile(wezterm.config_dir .. "\\.wezterm.common.lua")

config.default_domain = "WSL:NixOS"
config.enable_kitty_graphics = true
config.font_size = 10

config.background = {
	{
		source = { File = "\\\\wsl.localhost\\NixOS\\home\\nixos\\.files\\terminal.jpg" },
		hsb = { brightness = 0.1 },
	},
}

-- WSL: use alt_screen detection instead of process name since process names
-- are unreliable across the WSL boundary.
common.apply(config, {
	status_bg = "#b7bdf8",
	pane_is_shell = function(pane)
		return not pane:is_alt_screen_active()
	end,
	keys = {
		-- WSL is weird about ctrl+enter, so we have to send the escape sequence directly
		-- (see copilot custom mapping in git.lua)  WSL: ConPTY strips <C-CR>, so WezTerm sends this explicit CSI-u sequence instead
		{ key = "Enter", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[13;5u" }) },
	},
})

return config
