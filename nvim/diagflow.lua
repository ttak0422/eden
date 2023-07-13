require("diagflow").setup({
  enable = true,
  max_width = 60,
  severity_colors = {
    error = "DiagnosticFloatingError",
    warning = "DiagnosticFloatingWarn",
    info = "DiagnosticFloatingInfo",
    hint = "DiagnosticFloatingHint",
  },
  gap_size = 1,
  scope = "cursor",
  padding_top = 2,
  padding_right = 2,
  text_align = "left",
})
