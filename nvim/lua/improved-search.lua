-- [nfnl] Compiled from nvim/fnl/improved-search.fnl by https://github.com/Olical/nfnl, do not edit.
local search = require("improved-search")
vim.keymap.set({"n", "x", "o"}, "n", search.stable_next)
vim.keymap.set({"n", "x", "o"}, "N", search.stable_previous)
vim.keymap.set({"n"}, "!", search.current_word)
vim.keymap.set({"x"}, "!", search.in_place)
vim.keymap.set({"x"}, "*", search.forward)
vim.keymap.set({"x"}, "#", search.backward)
vim.keymap.set({"n"}, "|", search.in_place)
return nil
