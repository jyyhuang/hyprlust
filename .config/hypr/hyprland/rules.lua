require("hyprland.variables")

-- window rules
hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({ name = "firefox-workspace-2", match = { class = "firefox" }, workspace = "2" })
hl.window_rule({ name = "vesktop-workspace-3", match = { class = "vesktop" }, workspace = "3" })
hl.window_rule({ name = "fullscreen-border-color", match = { fullscreen = true }, border_color = colors.color14 })
hl.window_rule({ name = "nemo-opacity", match = { class = "nemo" }, opacity = "0.9" })
hl.window_rule({ match = { class = "wezterm" }, no_blur = true })

-- layer rules
hl.layer_rule({ name = "rofi-blur", match = { namespace = "rofi" }, blur = true, ignore_alpha = 0.5 })
