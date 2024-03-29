local wezterm = require("wezterm")

local function font_with_fallback(name, params)
	local names = { name, "Apple Color Emoji", "azuki_font" }
	return wezterm.font_with_fallback(names, params)
end

local font_name = "PragmataProMonoLiga Nerd Font"

return {
	-- OpenGL for GPU acceleration, Software for CPU
	front_end = "OpenGL",

	-- Font config
	font = font_with_fallback(font_name),
	font_rules = {
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback(font_name, { italic = true, bold = true }),
		},
		{
			italic = true,
			font = font_with_fallback(font_name, { italic = true }),
		},
		{
			intensity = "Bold",
			font = font_with_fallback(font_name, { bold = true }),
		},
	},
	audible_bell = "Disabled",
	warn_about_missing_glyphs = false,
	scrollback_lines = 10000,
	font_size = 11,
	line_height = 1.0,

	animation_fps = 30,

	-- Cursor style
	default_cursor_style = "BlinkingBlock",

	-- X11
	enable_wayland = false,

	-- Keybinds
	disable_default_key_bindings = true,
	keys = {
		{
			key = "q",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Left" }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Right" }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Up" }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Down" }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
		},
		{ -- browser-like bindings for tabbing
			key = "t",
			mods = "CTRL",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
		},
		{
			key = "Tab",
			mods = "CTRL",
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivateTabRelative = -1 }),
		}, -- standard copy/paste bindings
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		{
			key = "v",
			mods = "SUPER",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
		},
		{
			key = "c",
			mods = "SUPER",
			action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
		},
		{ mods = "CTRL", key = "-", action = "DecreaseFontSize" },
		{ mods = "SUPER", key = "-", action = "DecreaseFontSize" },
		{ mods = "CTRL", key = "=", action = "IncreaseFontSize" },
		{ mods = "SUPER", key = "=", action = "IncreaseFontSize" },
		{ mods = "CTRL", key = "0", action = "ResetFontSize" },
		{ mods = "SUPER", key = "0", action = "ResetFontSize" },
		{ key = "F11", action = "ToggleFullScreen" },
		{ mods = "CTRL|SHIFT", key = "F", action = wezterm.action({ Search = { CaseSensitiveString = "" } }) },
	},

	-- Aesthetic Night Colorscheme
	bold_brightens_ansi_colors = true,
	colors = {
		foreground = "#edeff0",
		background = "#0c0e0f",
		cursor_bg = "#edeff0",
		cursor_fg = "#edeff0",
		cursor_border = "#232526",
		selection_fg = "#0c0e0f",
		selection_bg = "#edeff0",
		scrollbar_thumb = "#edeff0",
		split = "#090909",
		ansi = { "#232526", "#df5b61", "#78b892", "#de8f78", "#6791c9", "#bc83e3", "#67afc1", "#e4e6e7" },
		brights = { "#2c2e2f", "#e8646a", "#81c19b", "#e79881", "#709ad2", "#c58cec", "#70b8ca", "#f2f4f5" },
		indexed = { [136] = "#edeff0" },
		tab_bar = {
			active_tab = { bg_color = "#0c0e0f", fg_color = "#edeff0" },
			inactive_tab = { bg_color = "#0c0e0f", fg_color = "#333333" },
			inactive_tab_hover = { bg_color = "#0c0e0f", fg_color = "#444444" },
			new_tab = { bg_color = "#0c0e0f", fg_color = "#333333" },
			new_tab_hover = { bg_color = "#0c0e0f", fg_color = "#444444" },
			inactive_tab_edge = "#333333",
		},
	},

	-- Padding
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- Tab Bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = true,

	-- General
	automatically_reload_config = true,
	inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
	window_background_opacity = 1.0,
	window_close_confirmation = "NeverPrompt",
	window_frame = { active_titlebar_bg = "#090909", font = font_with_fallback(font_name, { bold = true }) },
}
