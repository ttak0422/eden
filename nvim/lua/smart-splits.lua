-- [nfnl] Compiled from nvim/fnl/smart-splits.fnl by https://github.com/Olical/nfnl, do not edit.
local smart_splits = require("smart-splits")
return smart_splits.setup({ignored_filetypes = {"nofile", "quickfix", "prompt"}}, "ignored_buftypes", {"NvimTree"}, "default_amount", 3, "move_cursor_same_row", true, "resize_mode", {quit_key = "<ESC>", resize_keys = {"h", "j", "k", "l"}, hooks = {on_leave = (require("bufresize")).register}, silent = false}, "ignored_events", {BufEnter = "WinEnter"}, "log_level", "warn")
