local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font { family = 'Roboto', weight = 'Bold' },

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 13.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = '#333333',

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = '#333333',
}

config.tab_bar_at_bottom = true

-- or, changing the font size and color scheme.
config.font_size = 14
local color_scheme_name = 'tokyonight_moon'
config.color_scheme = color_scheme_name
local color_scheme = wezterm.get_builtin_color_schemes()[color_scheme_name]


-- Note the use of wezterm.color.parse here, this returns
-- a Color object, which comes with functionality for lightening
-- or darkening the colour (amongst other things).
local bg = wezterm.color.parse(color_scheme.background)

config.use_fancy_tab_bar = true
config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = '#575757',

		-- inactive_tab = {
		-- 	bg_color = '#ffffff',
		-- 	fg_color = '#000000',
		-- },
		active_tab = {
			bg_color = bg,
			fg_color = color_scheme.foreground,
		},
	},
}
return config
