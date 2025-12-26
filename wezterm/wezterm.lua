local wezterm = require "wezterm"
local config = wezterm.config_builder()
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
    return "Terminal"
end)
config.initial_cols = 90
config.initial_rows = 35
config.enable_tab_bar = false
config.font_size = 16
config.font = wezterm.font_with_fallback {
    '0xProGen Nerd',
    'Ricty Discord Nerd',
}
config.line_height = 1.0
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.colors = {
    cursor_bg = "#b7becc",
    cursor_border = "#8a8f99",
    cursor_fg = "#000000",
}
config.harfbuzz_features = {
    "calt=0",
    "clig=0",
    "liga=0",
}
config.adjust_window_size_when_changing_font_size = false
config.disable_default_key_bindings = true
--wezterm.on('window-resized', function(window, pane)
--    local window_dims = window:get_dimensions()
--    local current_height = window_dims.pixel_height
--    local current_width = window_dims.pixel_width
--    local screen = wezterm.gui.screens()["active"]
--    local screen_height = screen.height
--    local screen_width = screen.width
--    window:toast_notification("Window Resized", string.format("Screen Width: %d\nScreen Height: %d\nWindow Width: %d\nWindow Height: %d", screen_width, screen_height, current_width, current_height), nil, 4000)
--end)
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
return config
