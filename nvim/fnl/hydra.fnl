(local hydra (require :hydra))
(local cmd (. (require :hydra.keymap-util) :cmd))
(local config {:invoke_on_body true :hint false})

;; submode for window
(let [heads [;; move window
             [:h :<C-w>h {:exit true}]
             [:j :<C-w>j {:exit true}]
             [:k :<C-w>k {:exit true}]
             [:l :<C-w>l {:exit true}]
             [:w :<C-w>w {:exit true}]
             [:<C-w> :<C-w>w {:desc false :exit true}]
             [:<C-h> :<C-w>h]
             [:<C-j> :<C-w>j]
             [:<C-k> :<C-w>k]
             [:<C-l> :<C-w>l]
             ;; swap window
             [:H (cmd "WinShift left")]
             [:J (cmd "WinShift down")]
             [:K (cmd "WinShift up")]
             [:L (cmd "WinShift right")]
             [:e
              ;; resize
              (fn []
                ((. (require :smart-splits) :start_resize_mode)))
              {:desc "resize mode" :exit true}]
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
             [";" nil {:desc false :exit true}]
             [:<CR> nil {:desc false :exit true}]]]
  (hydra {:name :Windows :mode :n :body :<C-w> : heads : config}))

nil
