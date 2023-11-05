(local hl (require :highlight_current_n))
(local opts {:silent true})

(hl.setup {:highlight_group :IncSearch})

(vim.keymap.set [:n] :n "<Plug>(highlight-current-n-n)" opts)
(vim.keymap.set [:n] :N "<Plug>(highlight-current-n-N)" opts)
(vim.keymap.set [:n] :* :*N opts)

nil
