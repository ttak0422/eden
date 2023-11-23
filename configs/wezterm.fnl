(let [wezterm (require :wezterm)
      act wezterm.action
      keys [{:key "=" :mods :CTRL :action act.IncreaseFontSize}
            {:key :Enter :mods :ALT :action act.DisableDefaultAssignment}
            {:key :f :mods :SHIFT|SUPER :action act.ToggleFullScreen}]
      window_padding {:left 5 :right 5 :top 5 :bottom 0}]
  {:color_scheme "Everforest Dark (Gogh)"
   :font (wezterm.font_with_fallback {"PlemolJP Console NF" "JetBrains Mono"
                                      "Noto Color Emoji" "Symbols Nerd Font Mono"})
   :allow_square_glyphs_to_overflow_width :WhenFollowedBySpace
   :window_decorations :RESIZE
   :enable_tab_bar false
   :adjust_window_size_when_changing_font_size false
   : keys
   : window_padding})
