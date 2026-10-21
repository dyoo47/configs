-- Pull in the wezterm API
local wezterm = require 'wezterm'

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(wezterm.strftime('%a %b %d %I:%M %p') .. ' ')
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- or, changing the font size and color scheme.
config.font = wezterm.font 'Iosevka'
config.font_size = 14
config.color_scheme = 'Ayu Mirage'
config.tab_bar_at_bottom = false
config.tab_max_width = 32

config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

config.keys = {
  {
    key = 'n',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'm',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'n',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SplitPane {
      direction = 'Left',
      size = { Percent = 50 },
    },
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SplitPane {
      direction = 'Up',
      size = { Percent = 50 },
    },
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'q',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ToggleFullScreen,
  },
  { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Left" },
  { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Right" },
  { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Up" },
  { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection "Down" },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.MoveTabRelative(-1) },
  { key = 'RightArrow',  mods = 'ALT', action = wezterm.action.MoveTabRelative(1) }
  }

-- Finally, return the configuration to wezterm:
return config
