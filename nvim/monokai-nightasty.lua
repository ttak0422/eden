vim.opt.background = "dark"

require("monokai-nightasty").setup({
  dark_style_background = "default",
  light_style_background = "default",
  terminal_colors = true,
  color_headers = true,
  hl_styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = {},
    variables = {},
    floats = "default",
    sidebars = "default",
  },
  sidebars = { "qf", "help" },

  hide_inactive_statusline = false,
  dim_inactive = false,
  lualine_bold = true,
  lualine_style = "dark",

  on_colors = function(colors)
  end,

  on_highlights = function(highlights, colors)
  end,
})
