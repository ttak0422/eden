-- [nfnl] Compiled from nvim/fnl/bufresize.fnl by https://github.com/Olical/nfnl, do not edit.
local bufresize = require("bufresize")
local register = {keys = {}, trigger_events = {"BufWinEnter", "WinEnter"}}
local resize = {keys = {}, trigger_events = {"VimResized"}, increment = false}
return bufresize.setup({register = register, resize = resize})
