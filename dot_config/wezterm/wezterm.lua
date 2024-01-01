local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font_with_fallback({
	{ family = "Fira Code", weight = "Medium" },
	"Apple Color Emoji",
})
config.cell_width = 0.9
config.font_size = 13.0
config.freetype_load_target = "Light"

config.default_prog = { os.getenv("HOME") .. "/.nix-profile/bin/fish" }

return config
