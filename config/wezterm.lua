local wezterm = require("wezterm")

local function font_with_fallback(name, params)
	local names = { name, "Apple Color Emoji", "azuki_font" }
	return wezterm.font_with_fallback(names, params)
end

local font_name = "PragmataPro Mono Liga"

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
	font_size = 16,
	line_height = 1.0,

	-- Cursor style
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 750,

	-- Window
	window_background_opacity = 0.9,
	window_decorations = "RESIZE",
	window_padding = {
		left = 1,
		right = 1,
		top = 0,
		bottom = 0,
	},
	initial_cols = 180,
	initial_rows = 48,
	adjust_window_size_when_changing_font_size = false,

	-- MacOS specific
	macos_window_background_blur = 10,
	native_macos_fullscreen_mode = false,
	window_close_confirmation = "NeverPrompt",
	send_composed_key_when_left_alt_is_pressed = true,
	send_composed_key_when_right_alt_is_pressed = true,
	prefer_to_spawn_tabs = false,

	-- Colors (Catppuccin Latte theme to match your Alacritty)
	colors = {
		foreground = "#4C4F69",
		background = "#FFFFFF",
		cursor_bg = "#DC8A78",
		cursor_fg = "#FFFFFF",
		cursor_border = "#DC8A78",
		selection_fg = "#FFFFFF",
		selection_bg = "#DC8A78",
		
		ansi = {
			"#5C5F77", -- black
			"#D20F39", -- red
			"#40A02B", -- green
			"#DF8E1D", -- yellow
			"#1E66F5", -- blue
			"#EA76CB", -- magenta
			"#179299", -- cyan
			"#ACB0BE", -- white
		},
		brights = {
			"#6C6F85", -- bright black
			"#D20F39", -- bright red
			"#40A02B", -- bright green
			"#DF8E1D", -- bright yellow
			"#1E66F5", -- bright blue
			"#EA76CB", -- bright magenta
			"#179299", -- bright cyan
			"#BCC0CC", -- bright white
		},
		
		visual_bell = "#202020",
		
		tab_bar = {
			background = "#FFFFFF",
			active_tab = {
				bg_color = "#FFFFFF",
				fg_color = "#4C4F69",
			},
			inactive_tab = {
				bg_color = "#FFFFFF",
				fg_color = "#6C6F85",
			},
			inactive_tab_hover = {
				bg_color = "#FFFFFF",
				fg_color = "#4C4F69",
			},
			new_tab = {
				bg_color = "#FFFFFF",
				fg_color = "#6C6F85",
			},
			new_tab_hover = {
				bg_color = "#FFFFFF",
				fg_color = "#4C4F69",
			},
		},
	},

	-- Tab Bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = false,

	-- Key bindings
	keys = {
		{ key = "V", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{ key = "C", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
		{ key = "V", mods = "CMD", action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{ key = "C", mods = "CMD", action = wezterm.action({ CopyTo = "Clipboard" }) },
		{ key = "Insert", mods = "SHIFT", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
		{ key = "0", mods = "CTRL", action = "ResetFontSize" },
		{ key = "=", mods = "CTRL", action = "IncreaseFontSize" },
		{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
		{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
		{ key = "F11", mods = "NONE", action = "ToggleFullScreen" },
		{ key = "Return", mods = "CMD", action = "ToggleFullScreen" },
		{ key = "L", mods = "CTRL", action = wezterm.action({ ClearScrollback = "ScrollbackAndViewport" }) },
		{ key = "PageUp", mods = "NONE", action = wezterm.action({ ScrollByPage = -1 }) },
		{ key = "PageDown", mods = "NONE", action = wezterm.action({ ScrollByPage = 1 }) },
		{ key = "Home", mods = "SHIFT", action = "ScrollToTop" },
		{ key = "End", mods = "SHIFT", action = "ScrollToBottom" },
		{ key = "N", mods = "CMD", action = "SpawnWindow" },
	},

	-- Mouse bindings
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CMD",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},

	-- Hyperlink rules (matching your Alacritty config)
	hyperlink_rules = {
		{
			regex = "(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\\\s{-}\\\\^⟨⟩`]+",
			format = "$0",
		},
	},

	-- General
	automatically_reload_config = true,
	check_for_updates = false,
	use_ime = true,
	enable_kitty_graphics = true,
	term = "xterm-256color",
}