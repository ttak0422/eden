require("hover").setup({
  init = function()
    require("hover.providers.lsp")
  end,
  preview_opts = {
    border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
  },
  preview_window = false,
  title = false,
})
