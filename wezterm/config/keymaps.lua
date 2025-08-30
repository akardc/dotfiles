local wezterm = require("wezterm")

local function move_pane(key, direction)
	return {
		-- label = string.format("Move %s one pane", direction),
		key = key,
		-- mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection(direction),
	}
end

local function resize_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize({ direction, 3 }),
	}
end

local pub = {}

---@param config {keys: table, key_tables: table, leader: table } Wezterm config
function pub.apply_to_config(config)
	if config == nil then
		config = {}
	end

	-- <c-,>
	config.leader = { key = ",", mods = "CTRL", timeout_milliseconds = 1000 }

	if config.keys == nil then
		config.keys = {}
	end

	table.insert(config.keys, {
		label = "Move cursor backward one word",
		-- When the left arrow is pressed
		key = "LeftArrow",
		-- With the "Option" key modifier held down
		mods = "OPT",
		-- Perform this action, in this case - sending ESC + B
		-- to the terminal
		action = wezterm.action.SendString("\x1bb"),
	})
	table.insert(config.keys, {
		label = "Move cursor forward one word",
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action.SendString("\x1bf"),
	})
	table.insert(config.keys, {
		label = "Open Wezterm settings in a new tab",
		key = ",",
		mods = "SUPER",
		action = wezterm.action.SpawnCommandInNewTab({
			cwd = wezterm.home_dir,
			args = { "nvim", wezterm.config_file },
		}),
	})
	table.insert(config.keys, {
		label = "Split Horizontal",
		mods = "LEADER",
		key = "_",
		-- wezterm defines vertical/horizontal splits opposite of what I'd expect, so just swap them
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	})
	table.insert(config.keys, {
		label = "Split Vertical",
		mods = "LEADER",
		key = "|",
		-- wezterm defines vertical/horizontal splits opposite of what I'd expect, so just swap them
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	})
	table.insert(config.keys, {
		-- <LEADER>r
		label = "Activate Pane Resizing",
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes",
			one_shot = false,
			timeout_milliseconds = 1000,
		}),
	})
	table.insert(config.keys, {
		-- <LEADER>w
		label = "Move between panes",
		key = "w",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "move_between_panes",
			one_shot = false,
			timeout_milliseconds = 1000,
		}),
	})

	if config.key_tables == nil then
		config.key_tables = {}
	end

	config.key_tables["resize_panes"] = {
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("h", "Left"),
		resize_pane("l", "Right"),
		{ key = "Escape", action = "PopKeyTable" },
	}

	config.key_tables["move_between_panes"] = {
		move_pane("j", "Down"),
		move_pane("k", "Up"),
		move_pane("h", "Left"),
		move_pane("l", "Right"),
		{ key = "Escape", action = "PopKeyTable" },
	}
end

return pub
