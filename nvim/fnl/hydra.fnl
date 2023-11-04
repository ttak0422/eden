(local hydra (require :hydra))
(local cmd (. (require :hydra.keymap-util) :cmd))

;; TODO: integrate with heirline

;; submode for window
(let [heads [;; move window
             [:h :<C-w>h]
             [:j :<C-w>j]
             [:k :<C-w>k]
             [:l :<C-w>l]
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
             [:z (cmd :NeoZoomToggle)]
             ;; close
             [:q (cmd :SafeCloseWindow)]
             [:<C-q> (cmd :SafeCloseWindow) {:desc false}]
             [:o :<C-w>o {:desc "close other" :exit true}]
             [:<C-o> :<C-w>o {:desc false :exit true}]
             ;; quit
             [:<Esc> nil {:desc false :exit true}]
             [:<CR> nil {:desc false :exit true}]]]
  (hydra {:name :Window :mode :n :body :<C-w> : heads}))

nil
