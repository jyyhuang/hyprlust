-- autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("wal -R")
	hl.exec_cmd("wezterm")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("awww-daemon & waybar & hypridle")
end)
