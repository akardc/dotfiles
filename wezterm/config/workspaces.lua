local wezterm = require("wezterm")
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local M = {}

---@param config {keys: table, key_tables: table } Wezterm config
function M.init_workspace_settings(config)
	wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
		local workspace_state = resurrect.workspace_state

		workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
			window = window,
			relative = true,
			restore_text = true,
			on_pane_restore = resurrect.tab_state.default_on_pane_restore,
		})
	end)

	-- Saves the state whenever I select a workspace
	wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
		local workspace_state = resurrect.workspace_state
		resurrect.state_manager.save_state(workspace_state.get_workspace_state())
	end)

	wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

	resurrect.state_manager.set_encryption({
		enable = true,
		method = "age", -- "age" is the default encryption method, but you can also specify "rage" or "gpg"
		private_key = "~/.config/wezterm/workspace_private_key.txt", -- if using "gpg", you can omit this
		public_key = "age1gkc5yrdvt73wjm9gff6guj34e99cqr5wuzr34p9595rxymxdlcysdnt98s",
	})

	resurrect.state_manager.periodic_save()

	if config == nil then
		config = {}
	end

	if config.keys == nil then
		config.keys = {}
	end

	table.insert(config.keys, {
		label = "Workspace shortcuts",
		key = "w",
		mods = "ALT",
		action = wezterm.action.ActivateKeyTable({
			name = "workspace_shortcuts",
			one_shot = true,
			timeout_milliseconds = 1000,
		}),
	})

	if config.key_tables == nil then
		config.key_tables = {}
	end

	config.key_tables["workspace_shortcuts"] = {
		{ key = "Escape", action = "PopKeyTable" },

		{
			label = "Switch workspace",
			key = "s",
			action = workspace_switcher.switch_workspace(),
		},

		{
			label = "Switch to previous workspace",
			key = "S",
			action = workspace_switcher.switch_to_prev_workspace(),
		},

		{
			key = "w",
			action = wezterm.action_callback(function(win, pane)
				resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
			end),
		},

		{
			key = "W",
			action = resurrect.window_state.save_window_action(),
		},

		{
			key = "T",
			action = resurrect.tab_state.save_tab_action(),
		},

		{
			key = "x",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
					resurrect.state_manager.delete_state(id)
				end, {
					title = "Delete State",
					description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
					fuzzy_description = "Search State to Delete: ",
					is_fuzzy = true,
				})
			end),
		},

		{
			label = "Create new workspace",
			key = "n",
			action = wezterm.action.PromptInputLine({
				description = wezterm.format({
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},

		{
			key = "l",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
					local type = string.match(id, "^([^/]+)") -- match before '/'
					id = string.match(id, "([^/]+)$") -- match after '/'
					id = string.match(id, "(.+)%..+$") -- remove file extention
					local opts = {
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					}
					if type == "workspace" then
						local state = resurrect.state_manager.load_state(id, "workspace")
						resurrect.workspace_state.restore_workspace(state, opts)
					elseif type == "window" then
						local state = resurrect.state_manager.load_state(id, "window")
						resurrect.window_state.restore_window(pane:window(), state, opts)
					elseif type == "tab" then
						local state = resurrect.state_manager.load_state(id, "tab")
						resurrect.tab_state.restore_tab(pane:tab(), state, opts)
					end
				end)
			end),
		},

		{
			label = "Rename workspace",
			key = "r",
			action = wezterm.action.PromptInputLine({
				description = "Enter new name for workspace",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
						resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
					end
				end),
			}),
		},
	}

	return config
end

return M
