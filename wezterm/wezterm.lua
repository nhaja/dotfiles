local wezterm = require("wezterm")
config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "TITLE | RESIZE",
	default_cursor_style = "BlinkingBar",
	color_scheme = "GitHub Dark",
	font = wezterm.font("JetBrains Mono"),
	font_size = 14,
	background = {
		{
			source = {
				Color = "#24292e",
			},
			width = "100%",
			height = "100%",
			opacity = 0.9,
		},
	},
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},
	use_dead_keys = true,
	send_composed_key_when_left_alt_is_pressed = true,
	send_composed_key_when_right_alt_is_pressed = true,
	enable_kitty_keyboard = true,
	enable_csi_u_key_encoding = false,
	keys = {
		{ key = "n", mods = "OPT", action = wezterm.action({ SendString = "~" }) },
		{ key = "q", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
		{ key = "h", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
		{ key = "k", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
		{ key = "f", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
		{ key = "Enter", mods = "OPT", action = wezterm.action.DisableDefaultAssignment },
		{ key = "r", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
	},
}

return config
