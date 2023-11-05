(local hydra (require :hydra))
(local cmd (. (require :hydra.keymap-util) :cmd))
(local config {:invoke_on_body true :hint false})

;; submode for window
(let [heads [;; move window
             [:h :<C-w>h]
             [:j :<C-w>j]
             [:k :<C-w>k]
             [:l :<C-w>l]
             [:w :<C-w>w]
             [:<C-w> :<C-w>w {:desc false}]
             ;; swap window
             [:H (cmd "WinShift left")]
             [:J (cmd "WinShift down")]
             [:K (cmd "WinShift up")]
             [:L (cmd "WinShift right")]
             ;; resize window
             [:<C-h>
              (fn []
                ((. (require :smart-splits) :resize_left) 2))]
             [:<C-j>
              (fn []
                ((. (require :smart-splits) :resize_down) 2))]
             [:<C-k>
              (fn []
                ((. (require :smart-splits) :resize_up) 2))]
             [:<C-l>
              (fn []
                ((. (require :smart-splits) :resize_right) 2))]
             ["=" :<C-w>= {:desc :equalize}]
             ;; split
             [:s :<C-w>s {:desc false :exit true}]
             [:v :<C-w>v {:desc false :exit true}]
             ;; zoom
             [:z (cmd :NeoZoomToggle) {:desc :zoom}]
             ;; close
             [:q (cmd :SafeCloseWindow) {:exit true :desc :close}]
             [:<C-q> (cmd :SafeCloseWindow) {:desc false :exit true}]
             [:o :<C-w>o {:desc "close other" :exit true}]
             [:<C-o> :<C-w>o {:desc false :exit true}]
             ;; quit
             [:<Esc> nil {:desc false :exit true}]
             [:<CR> nil {:desc false :exit true}]]]
  (hydra {:name :Windows :mode :n :body :<C-w> : heads : config}))

nil
