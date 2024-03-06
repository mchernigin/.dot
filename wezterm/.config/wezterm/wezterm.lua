local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("IosevkaTerm Nerd Font", { weight = "Medium" })
config.font_size = 16.0

config.color_scheme = "One Light (Gogh)"
-- config.colors = {
-- 	selection_fg = "none",
-- 	selection_bg = "#252335",
-- 	background = "#0F1116",
-- }

config.adjust_window_size_when_changing_font_size = false
config.native_macos_fullscreen_mode = true
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
