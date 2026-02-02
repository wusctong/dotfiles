local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 30

config.font_size = 12.5
config.font = wezterm.font({
	family = "Maple Mono NF CN",
	harfbuzz_features = { "calt=1", "cv01=1", "cv65=1", "ss02=1" },
})

config.default_cwd = "~"
config.default_domain = "WSL:Debian"

config.use_fancy_tab_bar = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.color_scheme = "Tokyo Night Moon"
config.window_frame = {
	font_size = 10.0,
	font = wezterm.font({
		family = "Maple Mono NF CN",
		harfbuzz_features = { "calt=1", "cv01=1", "ss02=1" },
		weight = "ExtraLight",
	}),
	active_titlebar_bg = "#222436",
	inactive_titlebar_bg = "#222436",
}
config.colors = {
	tab_bar = {
		background = "#222436",
		inactive_tab_edge = "#1e2030",
		active_tab = {
			bg_color = "#82aaff",
			fg_color = "#1e2030",
		},
		inactive_tab = {
			bg_color = "#2f334d",
			fg_color = "#545c7e",
		},
		inactive_tab_hover = {
			bg_color = "#2f334d",
			fg_color = "#82aaff",
			intensity = "Bold",
		},
		new_tab = {
			bg_color = "#222436",
			fg_color = "#82aaff",
		},
		new_tab_hover = {
			bg_color = "#222436",
			fg_color = "#82aaff",
			intensity = "Bold",
		},
	},
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
