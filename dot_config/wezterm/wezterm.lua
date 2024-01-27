local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
	{ family = "Iosevka Comfy", weight = "Regular" },
	{ family = "Fira Code", weight = "Medium" },
	"Apple Color Emoji",
})
-- config.cell_width = 0.9
config.font_size = 12.0
config.freetype_load_target = "Light"

config.default_prog = { os.getenv("HOME") .. "/.nix-profile/bin/fish" }

-- config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_background_opacity = 0.9

return config
