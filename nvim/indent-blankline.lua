vim.opt.list = true
require("ibl").setup({
  debounce = 500,
  viewport_buffer = { min = 100, max = 600 },
  indent = {
    char = "|",
    smart_indent_cap = true,
  },
  whitespace = {
    remove_blankline_trail = true,
  },
  scope = {
    -- defined in rainbow-delimiters
    highlight = {
      -- "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  },
})
require("ibl").overwrite({
  exclude = { filetypes = dofile(args.exclude_ft_path) },
})
