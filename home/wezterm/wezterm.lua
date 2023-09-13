local wezterm = require("wezterm")
local keybinds = require("keys")
local colors = require("colors")
local menu = require("menu")
local window = require("window")

local config = {
    -- GPU acceleration
    front_end = "OpenGL",

    -- Font Config
    font_size = 16,
    line_height = 1.0,
    font = 

    -- X11
    enable_wayland = true,

    --Keybinds
    keys = keybinds,
    fonts = {
        family = 'JetBrainsMono Nerd Font',
        weight = 'Medium',
        harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1'}
    },

    -- Window
    window_frame = window.frame,
    window_padding = window.padding,
    window_background_gradient = window.bgGradient,

    window_close_confirmation = 'NeverPrompt',
    
    -- Menu
    launch_menu = menu,

}


return config