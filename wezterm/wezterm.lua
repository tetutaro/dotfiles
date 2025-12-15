local wezterm = require "wezterm"
local config = wezterm.config_builder()
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
    return "Terminal"
end)
config.initial_cols = 90
config.initial_rows = 35
config.enable_tab_bar = false
config.font_size = 16
config.font = wezterm.font('0xProGen Nerd Regular')
config.line_height = 1.0
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.harfbuzz_features = {
    "calt=0",
    "clig=0",
    "liga=0",
}
return config
