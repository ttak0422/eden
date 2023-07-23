local wezterm = require("wezterm")

return {
  color_scheme = 'Everforest Dark (Gogh)',

  -- window_background_opacity = 0.96,
  -- text_background_opacity = 0.5,
  font = wezterm.font_with_fallback({
    "PlemolJP Console NF",
    "JetBrains Mono",
    "Noto Color Emoji",
    "Symbols Nerd Font Mono",
  }),

  allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",

  keys = {
    { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
  },
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 0,
  },
  window_decorations = "RESIZE",
  enable_tab_bar = false,
  adjust_window_size_when_changing_font_size = false,
}
