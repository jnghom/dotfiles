-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Tokyo Night Moon'
-- config.color_scheme = 'Tokyo Night Storm'
config.color_scheme = 'Catppuccin Frappe'


-- config.font = wezterm.font 'Fira Code'

-- config.font = wezterm.font('JetBrains Mono')
config.font = wezterm.font('Sarasa Term K')

config.font_size = 13
-- config.enable_wayland = false -- https://github.com/wez/wezterm/issues/1701
 -- config.front_end = "WebGpu"
-- config.front_end = "Software"
-- config.front_end = "OpenGL"
-- config.front_end = "Software"
config.front_end = "WebGpu"

-- and finally, return the configuration to wezterm
return config

