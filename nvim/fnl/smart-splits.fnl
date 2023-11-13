(local smart-splits (require :smart-splits))

(smart-splits.setup {:ignored_filetypes [:nofile :quickfix :prompt]}
                    :ignored_buftypes [:NvimTree] :default_amount 3
                    :move_cursor_same_row true :resize_mode
                    {:quit_key :<ESC>
                     :resize_keys [:h :j :k :l]
                     :silent false
                     :hooks {:on_leave (. (require :bufresize) :register)}}
                    :ignored_events {:BufEnter :WinEnter} :log_level :warn)
