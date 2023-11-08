((. (require :wf) :setup) {:theme :space})

(local which_key (require :wf.builtin.which_key))
;; <Leader> is <Space>
(vim.keymap.set [:n] :<Space><Space> (which_key {:text_insert_in_advance :<Space>})
                {:noremap true :silent true})

;; fuzzy finder
(vim.keymap.set [:n] :<Space><Space>f (which_key {:text_insert_in_advance :<Space>f})
                {:noremap true :silent true})

;; git
(vim.keymap.set [:n] :<Space><Space>g (which_key {:text_insert_in_advance :<Space>g})
                {:noremap true :silent true})

nil
