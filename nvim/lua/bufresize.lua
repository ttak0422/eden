-- [nfnl] Compiled from nvim/fnl/bufresize.fnl by https://github.com/Olical/nfnl, do not edit.
local bufresize = require("bufresize")
local register = {keys = {}, trigger_events = {"BufWinEnter", "WinEnter", "WinNew"}}
local resize = {keys = {}, trigger_events = {"VimResized", "WinClosed"}, increment = false}
return bufresize.setup({register = register, resize = resize})
