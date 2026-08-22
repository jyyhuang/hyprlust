local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	local function parse_json(data)
		local result = wezterm.serde.json_decode(data)
		return result
	end

	local function read_json(file)
		local f = assert(io.open(file, "rb"))
		local body = f:read("*all")
		f:close()
		return parse_json(body)
	end

	local wallust_colors_path = os.getenv("HOME") .. "/.config/wezterm/colors.json"
	local success, wallust_colors = pcall(read_json, wallust_colors_path)

	if not success then
		wezterm.log_error("Failed to load colors.json: " .. wallust_colors)
		return
	end

	local function hex2rgba(hex, alpha)
		hex = hex:gsub("#", "")
		local r = tonumber(hex:sub(1, 2), 16)
		local g = tonumber(hex:sub(3, 4), 16)
		local b = tonumber(hex:sub(5, 6), 16)
		return string.format("rgba(%s,%s,%s,%s)", r, g, b, alpha)
	end

	wezterm.add_to_config_reload_watch_list(wallust_colors_path)

	config.window_close_confirmation = "AlwaysPrompt"
	config.window_decorations = "NONE"
    config.front_end = "WebGpu"
	config.tab_max_width = 30
	config.max_fps = 120
	config.animation_fps = 120
	config.font_size = 14
	config.use_fancy_tab_bar = false
	config.force_reverse_video_cursor = true
	config.inactive_pane_hsb = {
		brightness = 0.4,
	}

	local opacity = 0.80
	config.window_background_opacity = opacity

	config.font = wezterm.font_with_fallback({
		{
			family = "Monocraft",
			harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
			weight = "Regular",
		},
        "JetBrains Mono"
	})

	config.colors = {
		split = wallust_colors.colors.color1,
		tab_bar = {
			background = hex2rgba(wallust_colors.special.background, opacity),
			active_tab = {
				bg_color = wallust_colors.colors.color14,
				fg_color = wallust_colors.special.background,
				intensity = "Bold",
				underline = "None",
				italic = true,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = wallust_colors.special.background,
				fg_color = wallust_colors.colors.color14,
				italic = false,
				strikethrough = true,
			},
			inactive_tab_hover = {
				bg_color = wallust_colors.colors.color8,
				fg_color = wallust_colors.colors.color0,
				italic = false,
			},
			new_tab = {
				bg_color = wallust_colors.special.background,
				fg_color = wallust_colors.colors.color14,
			},
			new_tab_hover = {
				bg_color = wallust_colors.colors.color14,
				fg_color = wallust_colors.special.background,
			},
		},
	}

	wezterm.on("toggle-background", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		if not overrides.window_background_opacity then
			overrides.window_background_opacity = 1.0
		else
			overrides.window_background_opacity = nil
		end
		window:set_config_overrides(overrides)
	end)

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local pane = tab.active_pane

		local title = pane.title or ""

		if title == "" and pane.foreground_process_name then
			title = pane.foreground_process_name
			title = title:gsub("(.*[/\\])", "")
		end

		-- Extract cwd basename safely
		local cwd = ""
		if pane.current_working_dir and pane.current_working_dir.file_path then
			cwd = pane.current_working_dir.file_path
			cwd = cwd:gsub("/$", "")
			cwd = cwd:match("([^/]+)$") or ""
		end

		-- Combine cwd + title
		if cwd ~= "" then
			title = string.format("%d: %s ~ %s", tab.tab_index + 1, cwd, title)
		else
			title = string.format("%d: / ~ %s", tab.tab_index + 1, title ~= "" and title or "zsh")
		end

		-- Truncate if needed
		if #title > max_width then
			title = wezterm.truncate_right(title, max_width - 1)
		end

		return {
			{ Text = " " .. title .. " " },
		}
	end)
end

return module
