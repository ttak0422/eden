require("project_nvim").setup({
  manual_mode = false,
  detection_methods = { "lsp", "pattern" },
  patterns = { ".git" },
  scope_chdir = "win",
})
