(local search (require :improved-search))

(vim.keymap.set [:n :x :o] :n search.stable_next)
(vim.keymap.set [:n :x :o] :N search.stable_previous)
(vim.keymap.set [:n] "*" search.current_word)
(vim.keymap.set [:n] "#" search.current_word)
(vim.keymap.set [:x] "*" search.in_place)
(vim.keymap.set [:x] "#" search.in_place)

nil
