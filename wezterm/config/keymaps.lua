local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local function move_pane(key, direction)
	return {
		label = string.format('Move %s one pane', direction),
		key = key,
		mods = 'LEADER',
		action = wezterm.action.ActivatePaneDirection(direction),
	}
end

local function resize_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize { direction, 3 }
	}
end

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
	{
		label = 'Move cursor backward one word',
		-- When the left arrow is pressed
		key = 'LeftArrow',
		-- With the "Option" key modifier held down
		mods = 'OPT',
		-- Perform this action, in this case - sending ESC + B
		-- to the terminal
		action = wezterm.action.SendString '\x1bb',
	},
	{
		label = 'Move cursor forward one word',
		key = 'RightArrow',
		mods = 'OPT',
		action = wezterm.action.SendString '\x1bf',
	},
	{
		label = 'Open Wezterm settings in a new tab',
		key = ',',
		mods = 'SUPER',
		action = wezterm.action.SpawnCommandInNewTab {
			cwd = wezterm.home_dir,
			args = { 'nvim', wezterm.config_file },
		},
	},
	{
		label = 'Split Horizontal',
		mods = 'LEADER',
		key = '"',
		action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
	},
	{
		label = 'Split Vertical',
		mods = 'LEADER',
		key = '%',
		action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
	},
	move_pane('j', 'Down'),
	move_pane('k', 'Up'),
	move_pane('h', 'Left'),
	move_pane('l', 'Right'),
	{
		-- When we push LEADER + R...
		label = 'Activate Pane Resizing',
		key = 'r',
		mods = 'LEADER',
		-- Activate the `resize_panes` keytable
		action = wezterm.action.ActivateKeyTable {
			name = 'resize_panes',
			-- Ensures the keytable stays active after it handles its
			-- first keypress.
			one_shot = false,
			-- Deactivate the keytable after a timeout.
			timeout_milliseconds = 1000,
		}
	},
}

config.key_tables = {
	resize_panes = {
		resize_pane('j', 'Down'),
		resize_pane('k', 'Up'),
		resize_pane('h', 'Left'),
		resize_pane('l', 'Right'),
	},
}

return config
