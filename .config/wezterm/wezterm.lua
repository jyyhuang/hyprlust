local appearance = require("appearance")
local keys = require("keys")

local config = {}

config.automatically_reload_config = true
config.scrollback_lines = 5000

appearance.apply_to_config(config)
keys.apply_to_config(config)

return config
