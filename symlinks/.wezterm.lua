local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local isWindows = package.config:sub(1,1) == '\\'
local mux = wezterm.mux
-- Set the default font
config.font = wezterm.font("GohuFont uni11 Nerd Font")
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Automatically start maximized
wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():maximize()
end)
-- allow to use ALT + number to switch tabs
config.keys = {}
for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- Specify wsl distroy and set to default when starting wezterm on my windows env.
config.wsl_domains = {
  {
    -- The name of this specific domain.  Must be unique amonst all types
    -- of domain in the configuration file.
    name = 'WSL:Ubuntu',

    -- The name of the distribution.  This identifies the WSL distribution.
    -- It must match a valid distribution from your `wsl -l -v` output in
    -- order for the domain to be useful.
    distribution = 'Ubuntu',
  },
}

local backgroundSource
local user = os.getenv("USER")
if isWindows then
  user = os.getenv("USERNAME")
  backgroundSource = "\\\\wsl.localhost\\Ubuntu\\home\\" .. user .."\\.files\\wallpapers\\terminal.jpg"
  config.default_domain = 'WSL:Ubuntu'
else
  backgroundSource = "/home/".. user .. "/.files/wallpapers/space.jpg"
end

-- Scroll bar options
config.enable_scroll_bar = true
config.min_scroll_bar_height = '2cell'
config.colors = {
  scrollbar_thumb = 'white',
}
-- Background image
config.background = {
     {
        source = {
          File = backgroundSource
        },
        hsb = { brightness = 0.1 },
     },
}
return config
