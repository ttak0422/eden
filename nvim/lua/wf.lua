-- [nfnl] Compiled from nvim/fnl/wf.fnl by https://github.com/Olical/nfnl, do not edit.
do end (require("wf")).setup({theme = "space"})
local which_key = require("wf.builtin.which_key")
vim.keymap.set({"n"}, "<Space><Space>", which_key({text_insert_in_advance = "<Space>"}), {noremap = true, silent = true})
vim.keymap.set({"n"}, "<Space><Space>f", which_key({text_insert_in_advance = "<Space>f"}), {noremap = true, silent = true})
vim.keymap.set({"n"}, "<Space><Space>g", which_key({text_insert_in_advance = "<Space>g"}), {noremap = true, silent = true})
return nil
