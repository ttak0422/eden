-- [nfnl] Compiled from nvim/fnl/marks.fnl by https://github.com/Olical/nfnl, do not edit.
local marks = require("marks")
return marks.setup({default_mappings = true, cyclic = true, refresh_interval = 500, sign_priority = {lower = 10, upper = 15, builtin = 8, bookmark = 20}, force_write_shada = false})
