-- [nfnl] Compiled from nvim/fnl/tshjkl.fnl by https://github.com/Olical/nfnl, do not edit.
local tshjkl = require("tshjkl")
local keymaps = {toggle = "<M-t>", toggle_outer = "<M-T>", toggle_named = "<S-M-n>", parent = "h", next = "j", prev = "k", child = "l"}
local marks = {parent = {hl_group = "Comment"}, child = {hl_group = "Error"}, next = {hl_group = "InfoFloat"}, current = {hl_group = "Substitute"}}
return tshjkl.setup({select_current_node = true, keymaps = keymaps, marks = marks})
