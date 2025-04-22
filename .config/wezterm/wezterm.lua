local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  -- enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  use_ime = true,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBar",
  color_scheme = "Nord (Gogh)",
  font = wezterm.font("Moralerspace Neon HWNF"),
  font_size = 13,
  background = {
    {
      source = {
        Color = "#15191e",
      },
      width = "100%",
      height = "100%",
      opacity = 0.8,
    },
  },
  window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
  },
  show_new_tab_button_in_tab_bar = false,
  -- only nightly 2024/12/16
  -- show_close_tab_button_in_tabs = false,
  colors = {
    tab_bar = {
      inactive_tab_edge = "none",
    },
  },
  enable_scroll_bar = false,
  window_padding = {
    left = 8,
    right = 8,
    top = 2,
    bottom = 2,
  },
  adjust_window_size_when_changing_font_size = false,
  macos_window_background_blur = 30,
  launch_menu = {},
  leader = { key = "m", mods = "CTRL", timeout_millisections = 1000 },
  keys = {
      { key = "-", mods = "LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
      { key = "\\",mods = "LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
      -- { key = "z", mods = "LEADER", action="TogglePaneZoomState" },
      { key = "c", mods = "LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
      { key = "LeftArrow", mods = "LEADER", action=wezterm.action{ActivatePaneDirection="Left"}},
      { key = "DownArrow", mods = "LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
      { key = "UpArrow", mods = "LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
      { key = "RightArrow", mods = "LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},
      { key = "h", mods = "LEADER", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
      { key = "j", mods = "LEADER", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
      { key = "k", mods = "LEADER", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
      { key = "l", mods = "LEADER", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
      { key = "t", mods = "LEADER", action=wezterm.action{CloseCurrentTab={confirm=true}}},
      { key = "x", mods = "LEADER", action=wezterm.action{CloseCurrentPane={confirm=true}}},

      { key = "n", mods="SHIFT|CTRL",     action="ToggleFullScreen" },
  },
}

return config
