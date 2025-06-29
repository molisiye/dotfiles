---@diagnostic disable: unused-local, redefined-local, undefined-field
local wezterm = require("wezterm")
local style = require("lua.style")
local keymap = require("lua.keymap")
local domains = require("lua.domains")
local config = wezterm.config_builder()
local gpus = wezterm.gui.enumerate_gpus()

style.apply(config)
keymap.apply(config)
domains.apply(config)

-- config.term = "wezterm"
-- set initial size for screens
config.initial_rows = 35
config.initial_cols = 150
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
-- config.freetype_load_target = 'Light'
-- config.freetype_render_target = 'HorizontalLcd'

-- config of tab bar
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.enable_tab_bar = true
config.default_cursor_style = "BlinkingBlock"

-- set transparent
-- config.window_background_opacity = 0.83
config.win32_system_backdrop = "Acrylic" -- "Auto" or "Acrylic"
config.animation_fps = 60
config.default_domain = "local"

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.webgpu_preferred_adapter = gpus[3]
	config.default_prog = { "pwsh", "-NoLogo" }
end

config.max_fps = 60
config.enable_kitty_graphics = true
config.window_close_confirmation = "NeverPrompt"

return config
