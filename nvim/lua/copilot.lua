-- [nfnl] Compiled from nvim/fnl/copilot.fnl by https://github.com/Olical/nfnl, do not edit.
local copilot = require("copilot")
return copilot.setup({enabled = true, keymap = {jump_prev = "[[", jump_next = "]]", accept = "<CR>", refresh = "gr", open = "<M-CR>", layout = {position = "bottom", ratio = 0.4}}, suggestion = {enabled = true, auto_trigger = true, debounce = 150, keymap = {accept = "<M-y>", next = "<M-]>", prev = "<M-[>", dismiss = "<M-e>", accept_word = false, accept_line = false}}, filetypes = {help = false, [{"."}] = false, gitrebase = false}, auto_refresh = false})
