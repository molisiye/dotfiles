local wezterm = require "wezterm"

return {
  default_prog = {'/usr/bin/zsh'},
  enable_tab_bar = true,
  font = wezterm.font_with_fallback {
    "Iosevka"
  },
  font_size = 14,
  color_scheme = "Catppuccin Mocha"
}
