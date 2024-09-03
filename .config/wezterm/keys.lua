local wezterm = require("wezterm")

local module = {}

local act = wezterm.action

function module.apply_to_config(config)
	-- timeout_milliseconds defaults to 1000 and can be omitted

	config.leader = { key = "LeftAlt", timeout_milliseconds = 1000 }
	config.keys = {
		{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "w", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },

		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

		{ key = "LeftArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "RightArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
		{ key = "UpArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "DownArrow", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },

		{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
		{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

		{ key = "f", mods = "LEADER", action = act.Search({ CaseSensitiveString = "" }) },
		{ key = "x", mods = "LEADER", action = act.ActivateCopyMode },

		{
			key = ";",
			mods = "LEADER",
			action = act.MoveTabRelative(-1),
		},

		{
			key = "'",
			mods = "LEADER",
			action = act.MoveTabRelative(1),
		},

		{
			key = "r",
			mods = "LEADER",
			action = wezterm.action.ReloadConfiguration,
		},
		{
			key = "b",
			mods = "LEADER",
			action = wezterm.action.EmitEvent("toggle-background"),
		},
	}

	for i = 0, 8 do
		table.insert(config.keys, {
			key = tostring(i + 1),
			mods = "LEADER",
			action = wezterm.action.ActivateTab(i),
		})
	end
end

return module
