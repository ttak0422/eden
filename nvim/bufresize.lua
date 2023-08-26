require("bufresize").setup({
  register = {
    keys = {},
    trigger_events = { "BufWinEnter", "WinEnter" },
  },
  resize = {
    keys = {},
    trigger_events = { "VimResized" },
    increment = false,
  },
})
