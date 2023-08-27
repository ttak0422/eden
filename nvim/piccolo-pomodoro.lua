require("piccolo-pomodoro").setup({
  on_update = function()
    vim.cmd([[redrawstatus]])
  end,
  on_complete_focus_time = function()
    vim.notify("Focus time is over!")
  end,
  on_complete_break_time = function()
    vim.notify("Break time is over!")
  end,
})
