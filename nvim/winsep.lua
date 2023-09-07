local win_sep = require("colorful-winsep")
win_sep.setup({
  symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
  create_event = function()
    local win_n = require("colorful-winsep.utils").calculate_number_windows()
    if win_n == 2 then
      local win_id = vim.fn.win_getid(vim.fn.winnr("h"))
      local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win_id), "filetype")
      if filetype == "NvimTree" then
        win_sep.NvimSeparatorDel()
      end
    end
  end,
})
-- reset
vim.opt.laststatus = 3
