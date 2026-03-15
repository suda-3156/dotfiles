local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
	font = wezterm.font({ family = "Moralerspace Neon HW", weight = "Medium" }),
	font_size = 12.8,
	line_height = 1.11,

	color_scheme = "Molokai (Gogh)",
	background = {
		{
			source = {
				Color = "#282a3a", -- https://github.com/Kirlovon/monokai-ghostty/blob/main/Monokai%20Pro%20Octagon
			},
			width = "100%",
			height = "100%",
			opacity = 0.85,
		},
	},
	window_padding = {
		left = 8,
		right = 8,
		top = 8,
		bottom = 0,
	},
	macos_window_background_blur = 25,

	automatically_reload_config = true,
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	use_ime = true,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	default_cursor_style = "BlinkingBar",
	window_frame = {
		inactive_titlebar_bg = "none",
		active_titlebar_bg = "none",
	},
	max_fps = 120,
	show_new_tab_button_in_tab_bar = false,
	colors = {
		tab_bar = {
			inactive_tab_edge = "none",
		},
	},
	enable_scroll_bar = false,
	adjust_window_size_when_changing_font_size = false,
}

return config
