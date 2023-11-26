(let [cfg {:font :Cica
           :no_line_number false
           :no_round_corner false
           :no_window_controls false
           :background_color "#aaaaff"
           :line_offset 1
           :line_pad 2
           :pad_horiz 80
           :pad_vert 100
           :shadow_blur_radius 0
           :shadow_color "#555555"
           :shadow_offset_x 0
           :shadow_offset_y 0
           :tab_width 4
           :theme "Solarized (dark)"}]
  (set vim.g.silicon_options cfg))
