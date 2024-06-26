-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'nord'
config.enable_tab_bar = false
config.font = wezterm.font("JetBrains Mono")
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- config.window_background_opacity = 0.8
-- config.use_fancy_tab_bar = false
-- config.show_tabs_in_tab_bar = false
-- config.show_new_tab_button_in_tab_bar = false

-- and finally, return the configuration to wezterm
return config

