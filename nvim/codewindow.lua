local codewindow = require("codewindow")
codewindow.setup({
  active_in_terminals = false,
  auto_enable = true,
  exclude_filetypes = dofile(args.exclude_ft_path),
  max_minimap_height = nil,
  max_lines = nil,
  minimap_width = 10,
  use_lsp = true,
  use_treesitter = true,
  use_git = true,
  width_multiplier = 4,
  z_index = 1,
  show_cursor = true,
  window_border = "none",
  relative = "win",
  events = { "TextChanged", "InsertLeave", "DiagnosticChanged", "FileWritePost" },
})
