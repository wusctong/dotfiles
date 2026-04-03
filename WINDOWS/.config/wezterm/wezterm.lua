local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 30

config.font_size = 18
config.font = wezterm.font_with_fallback({
	{ family = "Iosevka Term", harfbuzz_features = { "calt=1", "ss04=1" } },
	{ family = "Symbols Nerd Font Mono", weight = "Thin" },
})

config.default_cwd = "~"
config.default_domain = "WSL:archlinux"

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.color_scheme = "Catppuccin Mocha"
config.window_frame = {
	font_size = 14.0,
	font = wezterm.font_with_fallback({
		{ family = "Iosevka Term", harfbuzz_features = { "calt=1", "ss04=1" } },
		{ family = "Symbols Nerd Font Mono", weight = "Thin" },
	}),
}

config.keys = {
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("Clipboard"),
	},
}

return config
