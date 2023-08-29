local Type = require("piccolo-pomodoro.type")

local prefix = {
  [Type.TIMER_MODE.FOCUS] = {
    [Type.TIMER_STATE.IDLE] = " focus",
    [Type.TIMER_STATE.ACTIVE] = " focus",
    [Type.TIMER_STATE.PAUSE] = " focus",
  },
  [Type.TIMER_MODE.BREAK] = {
    [Type.TIMER_STATE.IDLE] = " break",
    [Type.TIMER_STATE.ACTIVE] = " focus",
    [Type.TIMER_STATE.PAUSE] = " focus",
  },
  [Type.TIMER_MODE.LONG_BREAK] = {
    [Type.TIMER_STATE.IDLE] = " break",
    [Type.TIMER_STATE.ACTIVE] = " break",
    [Type.TIMER_STATE.PAUSE] = " break",
  },
}

require("piccolo-pomodoro").setup({
  on_update = function()
    vim.cmd([[redrawstatus]])
  end,
  focus_format = function(ctx)
    return string.format("%s %02d:%02d", prefix[ctx.timer_mode][ctx.timer_state], ctx.m, ctx.s)
  end,
  break_format = function(ctx)
    return string.format("%s %02d:%02d", prefix[ctx.timer_mode][ctx.timer_state], ctx.m, ctx.s)
  end,
  on_start = function()
    if vim.fn.has("mac") == 1 then
      vim.fn.system(
        [[osascript -e 'display notification "Start!" with title "pomodoro" sound name "Bell"']]
      )
    else
      vim.notify("Start!")
    end
  end,
  on_pause = function()
    if vim.fn.has("mac") == 1 then
      vim.fn.system(
        [[osascript -e 'display notification "Pause!" with title "pomodoro" sound name "Bell"']]
      )
    else
      vim.notify("Pause!")
    end
  end,
  on_complete_focus_time = function()
    if vim.fn.has("mac") == 1 then
      vim.fn.system(
        [[osascript -e 'display notification "Focus time is over!" with title "pomodoro" sound name "Bell"']]
      )
    else
      vim.notify("Focus time is over!")
    end
  end,
  on_complete_break_time = function()
    if vim.fn.has("mac") == 1 then
      vim.fn.system(
        [[osascript -e 'display notification "Break time is over!" with title "pomodoro" sound name "Bell"']]
      )
    else
      vim.notify("Focus time is over!")
    end
  end,
})
