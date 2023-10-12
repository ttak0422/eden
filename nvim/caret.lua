require("caret").setup({
  options = {
    transparent = false,
    inverted_signs = false,
    styles = {
      bold = true,
      italic = true,
      strikethrough = true,
      undercurl = true,
      underline = true,
    },
    inverse = {
      match_paren = false,
      visual = false,
      search = false,
    },
  },
  mapping = {
    toggle_bg = nil,
  },
  groups = {},
})

vim.o.background = "dark"
vim.cmd("colorscheme caret")
