-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.set_environment_variables = {
	PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
}

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

wezterm.on('update-right-status', function(window, pane)
	-- Each element holds the text for a cell in a "powerline" style << fade
	local cells = {}

	-- Figure out the cwd and host of the current pane.
	-- This will pick up the hostname for the remote host if your
	-- shell is using OSC 7 on the remote host.
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		local cwd = ''

		if type(cwd_uri) == 'userdata' then
			-- Running on a newer version of wezterm and we have
			-- a URL object here, making this simple!
			cwd = cwd_uri.file_path
		else
			-- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
			-- which doesn't have the Url object
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find '/'
			if slash then
				-- and extract the cwd from the uri, decoding %-encoding
				cwd = cwd_uri:sub(slash):gsub('%%(%x%x)', function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end

		-- Remove the domain name portion of the hostname
		table.insert(cells, cwd)
	end

	-- I like my date/time in this style: "Wed Mar 3 08:14"
	local date = wezterm.strftime '%a %b %-d %I:%M %P'
	table.insert(cells, date)

	-- An entry for each battery (typically 0 or 1 battery)
	for _, b in ipairs(wezterm.battery_info()) do
		table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
	end

	-- local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

	local color_scheme = window:effective_config().resolved_palette
	-- Note the use of wezterm.color.parse here, this returns
	-- a Color object, which comes with functionality for lightening
	-- or darkening the colour (amongst other things).
	local bg = wezterm.color.parse(color_scheme.background)
	local fg = color_scheme.foreground

	-- Each powerline segment is going to be coloured progressively
	-- darker/lighter depending on whether we're on a dark/light colour
	-- scheme. Let's establish the "from" and "to" bounds of our gradient.
	local gradient_to = bg
	-- if appearance.is_dark() then
	local gradient_from = gradient_to:lighten(0.2)
	-- else
	-- 	gradient_from = gradient_to:darken(0.2)
	-- end

	-- Yes, WezTerm supports creating gradients, because why not?! Although
	-- they'd usually be used for setting high fidelity gradients on your terminal's
	-- background, we'll use them here to give us a sample of the powerline segment
	-- colours we need.
	local gradient = wezterm.color.gradient(
		{
			orientation = 'Horizontal',
			colors = { gradient_from, gradient_to },
		},
		#cells -- only gives us as many colours as we have segments.
	)

	-- We'll build up the elements to send to wezterm.format in this table.
	local elements = {}

	for i, cell in ipairs(cells) do
		local is_first = i == 1

		if is_first then
			table.insert(elements, { Background = { Color = 'none' } })
		end
		table.insert(elements, { Foreground = { Color = gradient[i] } })
		table.insert(elements, { Text = SOLID_LEFT_ARROW })

		table.insert(elements, { Foreground = { Color = fg } })
		table.insert(elements, { Background = { Color = gradient[i] } })
		table.insert(elements, { Text =  ' ' .. cell .. ' ' })
	end

	window:set_right_status(wezterm.format(elements))
end)

-- local allConfigs = {
-- 	require('config.keymaps'),
-- 	require('config.appearance'),
-- }
-- for _, c in ipairs(allConfigs) do
-- 	for k, v in pairs(c) do config[k] = v end
-- end

local c = require('config.keymaps')
for k, v in pairs(c) do config[k] = v end

c = require('config.appearance')
for k, v in pairs(c) do config[k] = v end

return config
