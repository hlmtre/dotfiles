local wezterm = require("wezterm")
return {
	enable_wayland = false,
	color_scheme = "Gruvbox Dark (Gogh)",
	font = wezterm.font("DejaVuSansM Nerd Font"),
	font_size = 9.5,
	command_palette_font = wezterm.font("DejaVuSansM Nerd Font"),
	command_palette_font_size = 10,
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
		{
			key = "_",
			mods = "ALT|SHIFT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "|",
			mods = "ALT|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "p",
			mods = "ALT|SHIFT",
			action = wezterm.action.PaneSelect({ alphabet = "1234567890" }),
		},
	},
}
