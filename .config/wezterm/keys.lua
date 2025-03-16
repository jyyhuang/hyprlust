local wezterm = require("wezterm")

local module = {}

local act = wezterm.action

function module.apply_to_config(config)

	config.keys = {
		{ key = "|", mods = "ALT|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "w", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) },

		{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },

		{ key = "LeftArrow", mods = "ALT", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "RightArrow", mods = "ALT", action = act.AdjustPaneSize({ "Right", 5 }) },
		{ key = "UpArrow", mods = "ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "DownArrow", mods = "ALT", action = act.AdjustPaneSize({ "Down", 5 }) },

		{ key = "z", mods = "ALT", action = act.TogglePaneZoomState },
		{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },

		{ key = "f", mods = "ALT", action = act.Search({ CaseSensitiveString = "" }) },
		{ key = "x", mods = "ALT", action = act.ActivateCopyMode },

		{
			key = ";",
			mods = "ALT",
			action = act.MoveTabRelative(-1),
		},

		{
			key = "'",
			mods = "ALT",
			action = act.MoveTabRelative(1),
		},

		{
			key = "r",
			mods = "ALT",
			action = wezterm.action.ReloadConfiguration,
		},
		{
			key = "b",
			mods = "ALT",
			action = wezterm.action.EmitEvent("toggle-background"),
		},
	}

	for i = 0, 8 do
		table.insert(config.keys, {
			key = tostring(i + 1),
			mods = "ALT",
			action = wezterm.action.ActivateTab(i),
		})
	end
end

return module
