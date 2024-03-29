(local copilot (require :copilot))

(copilot.setup {:enabled true
                :auto_refresh false
                :keymap {:jump_prev "[["
                         :jump_next "]]"
                         :accept :<CR>
                         :refresh :gr
                         :open :<M-CR>
                         :layout {:position :bottom :ratio 0.4}}
                :suggestion {:enabled true
                             :auto_trigger true
                             :debounce 150
                             :keymap {:accept :<M-y>
                                      :accept_word false
                                      :accept_line false
                                      :next "<M-]>"
                                      :prev "<M-[>"
                                      :dismiss :<M-e>}}
                :filetypes {:help false :gitrebase false "." false}})
