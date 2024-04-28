local wezterm = require("wezterm")
return {
	color_scheme = "Gruvbox Dark (Gogh)",
	font = wezterm.font("DejaVuSansMono Nerd Font"),
	font_size = 10.5,
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL|SHIFT",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
	keys = {
		{
			key = "r",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ReloadConfiguration,
		},
	},
}
