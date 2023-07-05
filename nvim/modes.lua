require("modes").setup({
  colors = {
    insert = "#78ccc5",
    visual = "#9745be",
  },
  line_opacity = 0.15,
  set_cursor = true,
  set_cursorline = true,
  set_number = false,
  ignore_filetypes = dofile(args.exclude_ft_path),
})
