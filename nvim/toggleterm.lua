require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return vim.o.lines * 0.3
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  shade_terminals = false,
  auto_scroll = false,
  start_in_insert = true,
  winbar = {
    enabled = true,
  },
})

local Terminal = require("toggleterm.terminal").Terminal
local toggle_terminal = (function()
  local terms = {}
  return function(idx)
    if not terms[idx] then
      terms[idx] = Terminal:new()
    end
    if terms[idx]:is_open() and not (terms[idx]:is_focused()) then
      terms[idx]:focus()
    else
      terms[idx]:toggle()
    end
  end
end)()
local toggle_tig = (function()
  local tig = Terminal:new({
    cmd = "tig",
    dir = "git_dir",
    direction = "float",
  })
  return function()
    tig:toggle()
  end
end)()

vim.api.nvim_create_user_command("TermToggle", function(opts)
  toggle_terminal(opts.args)
end, { nargs = 1 })
vim.api.nvim_create_user_command("TigTermToggle", toggle_tig, {})
