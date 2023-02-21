local wezterm = require "wezterm"
local act = wezterm.action

return {
    use_ime = true,
--    default_prog = {"/usr/bin/zsh", "-l"},
    font = wezterm.font_with_fallback({
       "Sarasa Mono SC Nerd", "JetBrainsMono Nerd Font", "FiraCode Nerd Font",
        "BlexMono Nerd Font"
    }),
font_rules = {
    -- For Bold-but-not-italic text, use this relatively bold font, and override
    -- its color to a tomato-red color to make bold text really stand out.
    {
      intensity = 'Bold',
      italic = false,
    font = wezterm.font_with_fallback({
       "Sarasa Mono SC Nerd", "JetBrainsMono Nerd Font", "FiraCode Nerd Font",
      }),
      --font = wezterm.font_with_fallback(
      --  'Operator Mono SSm Lig',
        -- Override the color specified by the terminal output and force
        -- it to be tomato-red.
        -- The color value you set here can be any CSS color name or
        -- RGB color string.
      --  { foreground = 'tomato' }
      --),
    }
  },

    front_end = "OpenGL",
    font_size = 14,
    color_scheme = "nord",
    enable_tab_bar = true,
    tab_max_width = 20,
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,
    audible_bell = "Disabled",
    colors = {
        tab_bar = {
            background = "#2e3440",
            active_tab = {
                bg_color = "#5e81ac",
                fg_color = "#eceff4",
                intensity = "Bold",
                italic = true
            },
            inactive_tab = {bg_color = "#4c566a", fg_color = "#d8dee9"},
            inactive_tab_hover = {
                bg_color = "#d8dee9",
                fg_color = "#3b4252",
                italic = false
            },
            new_tab = {bg_color = "#3b4252", fg_color = "#a3be8c"},
            new_tab_hover = {
                bg_color = "#3b4252",
                fg_color = "#8fbcbb",
                italic = false
            }
        }
    },
    text_background_opacity = 1.0,
    disable_default_key_bindings = true,
    mouse_bindings = {
        {

            event = {Up = {streak = 1, button = "Left"}},
            mods = "NONE",
            action = wezterm.action {
                CompleteSelectionOrOpenLinkAtMouseCursor = "Clipboard"
            }
        }, {
            event = {Up = {streak = 1, button = "Left"}},
            mods = "CTRL",
            action = "OpenLinkAtMouseCursor"
        }
    },
    keys = {
    {
      key = 't',
      mods = 'SHIFT|ALT',
      -- Create a new tab in the same domain as the current pane.
      action = act.SpawnTab 'CurrentPaneDomain',
      -- Create a new tab in the default domain
      -- action = act.SpawnTab 'DefaultDomain'
      -- Create a tab in a named domain
      -- action = act.SpawnTab { DomainName = 'unix'}
    },
    -- CMD-t start `top` in a new tab
    {
      key = 'y',
      mods = 'CMD',
      action = wezterm.action.SpawnCommandInNewTab {
        args={"top"}
      }
    }
  },
    window_background_opacity = 0.95
    -- window_background_image = "/home/ayamir/Pictures/wezterm/nord.jpg",
    -- window_background_image_hsb = {
    --     brightness = 2.0,
    --     hue = 1.0,
    --     saturation = 1.0
    -- }
}

