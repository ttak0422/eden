(local suit (require :suit))

(suit.setup {:input {:default_prompt "Input: "
                     :border :single
                     :hl_win :suitWin
                     :hl_prompt :suitPrompt
                     :hl_border :suitBorder
                     :width 30
                     :nvim_float_api nil}
             :select {:default_prompt "Select one of: "
                      :border :single
                      :hl_win :suitWin
                      :hl_prompt :suitPrompt
                      :hl_sel :suitSel
                      :hl_border :suitBorder
                      :nvim_float_api nil}})

nil
