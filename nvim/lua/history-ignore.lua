-- [nfnl] Compiled from nvim/fnl/history-ignore.fnl by https://github.com/Olical/nfnl, do not edit.
local history_ignore = require("history-ignore")
return history_ignore.setup({ignore_words = {"^buf$", "^history$", "^h$", "^q$", "^qa$", "^w$", "^wq$", "^wa$", "^wqa$", "^q!$", "^qa!$", "^w!$", "^wq!$", "^wa!$", "^wqa!$"}})
