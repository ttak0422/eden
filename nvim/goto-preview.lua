require("goto-preview").setup({
  border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
  height = 30,
  post_open_hook = function(_, win)
    vim.api.nvim_win_set_option(win, "winhighlight", "Normal:")
  end,
})
