(let [registers (require :registers)
      bind_keys {:normal (registers.show_window {:mode :motion})
                 :visual (registers.show_window {:mode :motion})
                 :insert (registers.show_window {:mode :insert})
                 :registers (registers.apply_register {:delay 0.1})
                 :<CR> (registers.apply_register)
                 :<Esc> (registers.close_window)
                 :<C-n> (registers.move_cursor_down)
                 :<C-p> (registers.move_cursor_up)
                 :<C-j> (registers.move_cursor_down)
                 :<C-k> (registers.move_cursor_up)
                 :<Del> (registers.clear_highlighted_register)
                 :<BS> (registers.clear_highlighted_register)}
      events {:on_register_highlighted (registers.preview_highlighted_register {:if_mode {:insert :paste}})}
      symbols {:newline "⏎"
               :space " "
               :tab "·"
               :register_type_charwise "ᶜ"
               :register_type_linewise "ˡ"
               :register_type_blockwise "ᵇ"}
      window {:max_width 100
              :highlight_cursorline true
              :border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
              :transparency 0}
      sign_highlights {:cursorlinesign :CursorLine
                       :signcolumn :SignColumn
                       :cursorline :Visual
                       :selection :Constant
                       :default :Function
                       :unnamed :Statement
                       :read_only :Type
                       :expression :Exception
                       :black_hole :Error
                       :alternate_buffer :Operator
                       :last_search :Tag
                       :delete :Special
                       :yank :Delimiter
                       :history :Number
                       :named :Todo}]
  (registers.setup {:show "*\"/1234567890abcdefghijklmnopqrstuvwxyz#%.:"
                    :show_empty false
                    :register_user_command true
                    :system_clipboard true
                    :trim_whitespace true
                    :hide_only_whitespace true
                    :show_register_types true
                    : bind_keys
                    : events
                    : symbols
                    : window
                    : sign_highlights}))
